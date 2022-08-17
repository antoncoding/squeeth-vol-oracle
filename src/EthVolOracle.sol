// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import {ISqueethController} from "./interfaces/ISqueethController.sol";
import {IUniswapPool} from "./interfaces/IUniswapPool.sol";

contract EthVolOracle {
    ISqueethController public immutable squeethController;

    IUniswapPool public immutable squeethPool;
    IUniswapPool public immutable wethPool;

    constructor(address _squeethController) {
        squeethController = ISqueethController(_squeethController);

        // set pools
        squeethPool = IUniswapPool(
            ISqueethController(_squeethController).wPowerPerpPool()
        );
        wethPool = IUniswapPool(
            ISqueethController(_squeethController).ethQuoteCurrencyPool()
        );
    }

    /// @dev get the current implied vol by spot price of squeeth & weth
    function getEthImpliedVol() external view returns (uint256 vol) {}

    /// @dev get the current implied vol by twap price of squeeth & weth
    function getEthTwav(uint256 _seconds) external view returns (uint256 vol) {}
}
