// SPDX-License-Identifier: Unlicense
pragma solidity ^0.7.6;

import "forge-std/Test.sol";

import "src/EthVolOracle.sol";

import {MockController} from "./mocks/MockController.sol";
import {MockUniV3Pool} from "./mocks/MockPool.sol";

contract EthVolOracleTest is Test {
    EthVolOracle public oracle;

    MockUniV3Pool public squeethPool;
    MockUniV3Pool public wethPool;
    MockController public controller;

    // use the same as mainnet addresses to make sure token0/token1 in pools are correct
    address public wsqueeth =
        address(0xf1B99e3E573A1a9C5E6B2Ce818b617F0E664E86B);
    address public weth = address(0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2);
    address public usdc = address(0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48);

    function setUp() public {
        squeethPool = new MockUniV3Pool();
        wethPool = new MockUniV3Pool();

        controller = new MockController(
            wsqueeth,
            weth,
            usdc,
            address(squeethPool),
            address(wethPool)
        );

        oracle = new EthVolOracle(address(controller));

        // weth / usdc pool
        wethPool.setTickCumulatives(8015722992217, 8015843652483);
        wethPool.setSecondsPerLiquidityCumulativeX128s(
            198044337547992722534866431396715863307712,
            198044337547992722552119929700057690614920
        );

        // squeeth / weth pool
        controller.setNormFactor(504479078736905058);
        squeethPool.setTickCumulatives(347006158391, 347020144391);
        squeethPool.setSecondsPerLiquidityCumulativeX128s(
            877588224289100297820629220282594390325003,
            877588224289100297820649746077709246036708
        );
    }

    function testFetchEthTwap() public {
        uint256 price = oracle.fetchEthTwap(600);
        assertEq(price, 1848309190161561404259); // 1848.309190161561404259
    }

    function testFetchSqueethTwap() public {
        uint256 price = oracle.fetchSqueethTwap(600);
        assertEq(price, 1926934782064628189907); // 1926.934782064628189907
    }

    function testImpliedFunding() public {
        uint256 funding = oracle.getImpliedFunding(600);
        assertEq(funding, 2380529980419419); // 0.002380529980419419 ~ 0.238%
    }

    function testGetImpliedVol() public {
        uint256 vol = oracle.getEthTwaIV(600);
        assertEq(vol, 932144539678846123); // 0.932144539678846123 ~ 93%
    }
}
