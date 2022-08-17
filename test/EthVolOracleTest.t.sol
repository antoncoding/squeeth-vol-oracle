// SPDX-License-Identifier: Unlicense
pragma solidity ^0.7.6;

import "forge-std/Test.sol";

import "src/EthVolOracle.sol";

contract EthVolOracleTest is Test {
    EthVolOracle public oracle;

    function setUp() public {
        // oracle = new EthVolOracle();
    }

    function testBar() public {
        assertEq(uint256(1), uint256(1), "ok");
    }
}
