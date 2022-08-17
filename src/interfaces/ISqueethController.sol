// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface ISqueethController {
    ///@dev eth / usdc pool
    function ethQuoteCurrencyPool() external view returns (address);

    ///@dev squeeth / weth pool
    function wPowerPerpPool() external view returns (address);

    function weth() external view returns (address);

    function quoteCurrency() external view returns (address);

    function wPowerPerp() external view returns (address);

    ///@dev normalization factor, with 18 decimals
    function normalizationFactor() external view returns (uint128);
}
