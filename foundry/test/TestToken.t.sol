// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/TestToken.sol";

contract TestTokenTest is Test {
    TestToken token;

    function setUp() public {
        uint256 initialSupply = 10_000 * 10**18;
        token = new TestToken(initialSupply);
    }

    function testInitialSupply() public {
        uint256 expectedSupply = 10_000 * 10**18;
        assertEq(token.totalSupply(), expectedSupply);
    }

    function testTransfer() public {
        address recipient = address(0xBEEF);
        uint256 amount = 1_000 * 10**18;

        token.transfer(recipient, amount);

        assertEq(token.balanceOf(recipient), amount);
    }

    function testFailTransferWithoutEnoughBalance() public {
        address recipient = address(0xBEEF);
        uint256 amount = 1_000 * 10**18;

        token.transfer(recipient, amount);

        vm.prank(recipient);
        token.transfer(address(this), amount + 1);
    }
}
