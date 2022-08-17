// SPDX-License-Identifier: MIT
// solhint-disable no-empty-blocks

pragma solidity ^0.7.6;

import {IUniswapV3Pool} from "../../src/interfaces/IUniswapV3Pool.sol";

contract MockUniV3Pool is IUniswapV3Pool {
    int56[2] public _tickCumulatives;
    uint160[2] public _secondsPerLiquidityCumulX128s;

    function setTickCumulatives(int56 arg0, int56 arg1) external {
        _tickCumulatives[0] = arg0;
        _tickCumulatives[1] = arg1;
    }

    function setSecondsPerLiquidityCumulativeX128s(uint160 arg0, uint160 arg1)
        external
    {
        _secondsPerLiquidityCumulX128s[0] = arg0;
        _secondsPerLiquidityCumulX128s[1] = arg1;
    }

    function observe(
        uint32[] calldata /*secondsAgos*/
    ) external view override returns (int56[] memory, uint160[] memory) {
        int56[] memory tickCumulatives = new int56[](2);
        tickCumulatives[0] = _tickCumulatives[0];
        tickCumulatives[1] = _tickCumulatives[1];

        uint160[] memory secondsPerLiquCumulX128s = new uint160[](2);
        secondsPerLiquCumulX128s[0] = _secondsPerLiquidityCumulX128s[0];
        secondsPerLiquCumulX128s[1] = _secondsPerLiquidityCumulX128s[1];

        return (tickCumulatives, secondsPerLiquCumulX128s);
    }
}
