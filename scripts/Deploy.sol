// SPDX-License-Identifier: MIT
pragma solidity =0.7.6;

import "forge-std/Script.sol";

import {EthVolOracle} from "../src/EthVolOracle.sol";

contract Deploy is Script {
    
    address private constant squeethControllerMainnet =
        address(0x64187ae08781B09368e6253F9E94951243A493D5);

    function run() external {
        vm.startBroadcast();

        deploy();

        vm.stopBroadcast();
    }

    /// @dev the script currently only work with new deployer account (nonce = 0)
    function deploy() public {
        EthVolOracle oracle = new EthVolOracle(squeethControllerMainnet);
        
        uint256 gasBefore1 = gasleft();
        uint256 funding = oracle.getImpliedFunding(600);
        uint256 gasAfter1 = gasleft();
        console.log("implied funding:   ", funding);
        console.log("gas cost:          ", gasBefore1 - gasAfter1);

        uint256 vol = oracle.getEthTwaIV(60);
        console.log("implied volatility:", vol);
    }
}
