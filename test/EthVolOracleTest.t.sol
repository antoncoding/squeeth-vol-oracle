// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import "src/EthVolOracle.sol";

contract EthVolOracleTest is Test {
    EthVolOracle oracle;

    function setUp() public {
        oracle = new EthVolOracle();
    }

    function testBar() public {
        assertEq(uint256(1), uint256(1), "ok");
    }
}
