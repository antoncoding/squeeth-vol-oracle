// SPDX-License-Identifier: Unlicense
pragma solidity ^0.7.6;

import {ISqueethController} from "./interfaces/ISqueethController.sol";
import {IUniswapV3Pool} from "./interfaces/IUniswapV3Pool.sol";
import {OracleLibrary} from "@uniswap/v3-periphery/contracts/libraries/OracleLibrary.sol";
import {IERC20} from "./interfaces/IERC20.sol";

contract EthVolOracle {
    ISqueethController public immutable squeethController;

    address public immutable squeethPool;
    address public immutable wethPool;

    address public immutable weth;
    address public immutable squeeth;
    address public immutable quoteCurrency;

    uint8 public constant wethDecimals = 18;
    uint8 public constant squeethDecimals = 18;
    uint8 public constant quoteDecimals = 6;

    constructor(address _squeethController) {
        ISqueethController controller = ISqueethController(_squeethController);

        // set pools
        squeethPool = controller.wPowerPerpPool();
        wethPool = controller.ethQuoteCurrencyPool();

        weth = controller.weth();
        squeeth = controller.wPowerPerp();
        quoteCurrency = controller.quoteCurrency();

        squeethController = controller;
    }

    /// @dev get the current implied vol by twap price of squeeth & weth
    function getEthTwaIV(uint32 secondsAgo)
        external
        view
        returns (uint256 vol)
    {
        uint256 impliedFunding = getImpliedFunding(secondsAgo);

        vol = impliedFunding;
        // vol = impliedFunding.sqrt().mul(365 days);
    }

    function getImpliedFunding(uint32 secondsAgo)
        public
        view
        returns (uint256)
    {
        uint256 mark = _fetchSqueethTwap(secondsAgo);
        uint256 index = _fetchEthTwap(secondsAgo);
        if (index == 0) return 0;

        // return (mark / index).log() / 17.5;
        return ((mark / index) * 10) / 175;
    }

    /**
     * @notice get twap for squeeth
     * @param _period number of seconds in the past to start calculating time-weighted average
     * @return twap price scaled with 1e18
     */
    function _fetchSqueethTwap(uint32 _period) internal view returns (uint256) {
        uint256 quoteAmountOut = _fetchRawTwap(
            squeethPool,
            squeeth,
            weth,
            1e18,
            _period
        );

        // return directly becauase squeeth and weth has same decimals
        return quoteAmountOut;
    }

    /**
     * @notice get twap for weth / quote
     * @param _period number of seconds in the past to start calculating time-weighted average
     * @return twap price scaled with 1e18
     */
    function _fetchEthTwap(uint32 _period) internal view returns (uint256) {
        uint256 quoteAmountOut = _fetchRawTwap(
            wethPool,
            weth,
            quoteCurrency,
            1e18,
            _period
        );

        // weth has more decimals than USDC
        return quoteAmountOut * (10**(wethDecimals - quoteDecimals));
    }

    /**
     * @notice get raw twap from the uniswap pool
     * @dev if period is longer than the current timestamp - first timestamp stored in the pool, this will revert with "OLD".
     * @param _pool uniswap pool address
     * @param _base base currency. to get eth/usd price, eth is base token
     * @param _quote quote currency. to get eth/usd price, usd is the quote currency
     * @param secondsAgo number of seconds in the past to start calculating time-weighted average
     * @return amount of quote currency received for _amountIn of base currency
     */
    function _fetchRawTwap(
        address _pool,
        address _base,
        address _quote,
        uint128 _scale,
        uint32 secondsAgo
    ) internal view returns (uint256) {
        // (arithmeticMeanTick, harmonicMeanLiquidity)
        (int24 twapTick, ) = OracleLibrary.consult(_pool, secondsAgo);
        return OracleLibrary.getQuoteAtTick(twapTick, _scale, _base, _quote);
    }
}
