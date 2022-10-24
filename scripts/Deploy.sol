// SPDX-License-Identifier: MIT
pragma solidity =0.7.6;

import "forge-std/Script.sol";

import {EthVolOracle} from "../src/EthVolOracle.sol";

contract Deploy is Script {
    
    address private constant squeethMainnet = address(0x64187ae08781B09368e6253F9E94951243A493D5);
    address private constant squeethGoerli = address(0x50f3D0826d4E3c3d49007DBa664727B9885Dd734);

    function run() external {
        vm.startBroadcast();

        uint chainId;
        assembly { chainId := chainid() }
        require(chainId == 1 || chainId == 5, "wrong chain");

        console.log("deployer: ", msg.sender);

        deploy(chainId);

        vm.stopBroadcast();
    }

    /// @dev the script currently only work with new deployer account (nonce = 0)
    function deploy(uint256 chainId) public {
        EthVolOracle oracle = new EthVolOracle(
            chainId == 1 
                ? squeethMainnet
                : squeethGoerli
        );
        
        uint256 gasBefore1 = gasleft();
        uint256 vol = oracle.getEthTwaIV(120);
        uint256 gasAfter1 = gasleft();
        console.log("implied volatility:", vol);
        console.log("gas cost:          ", gasBefore1 - gasAfter1);

        uint256 funding = oracle.getImpliedFunding(120);
        console.log("implied funding:   ", funding);
    }
}
