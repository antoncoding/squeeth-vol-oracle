// SPDX-License-Identifier: MIT
// solhint-disable no-empty-blocks

pragma solidity ^0.7.6;

import {ISqueethController} from "../../src/interfaces/ISqueethController.sol";

contract MockController is ISqueethController {
    address public immutable override wPowerPerp;
    address public immutable override weth;
    address public immutable override quoteCurrency;

    address public immutable override wPowerPerpPool;
    address public immutable override ethQuoteCurrencyPool;
    

    uint128 public override normalizationFactor;

    constructor(
        address _wPowerPerp,
        address _weth,
        address _quoteCurrency,
        address _wPowerPerpPool,
        address _ethQuoteCurrencyPool

    ) {
        wPowerPerp = _wPowerPerp;
        weth = _weth;
        quoteCurrency = _quoteCurrency;
        wPowerPerpPool = _wPowerPerpPool;
        ethQuoteCurrencyPool = _ethQuoteCurrencyPool;
    }

    function setNormFactor(uint128 _normFactor) external {
        normalizationFactor = _normFactor;
    }
}
