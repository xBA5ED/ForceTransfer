// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/ForceTransfer.sol";

contract ContractTest is Test {

    ForceTransfer fTransfer;

    function setUp() public {
        fTransfer = new ForceTransfer();
    }

    function testTransfer() public {
        testTransferFuzz(address(0x100000), address(0x200000), 1 ether);
    }

    function testTransferMultiple() public {
        testTransferFuzz(address(0x100000), address(0x200000), 1 ether);
        testTransferFuzz(address(0x200000), address(0x100000), 1 ether);
    }

    function testTransferFuzz(address sender, address recipient, uint256 amount) public {
        vm.assume(sender != address(0x0000000000000000000000000000000000000000));

        uint256 recipientBalanceBefore = recipient.balance;

        vm.deal(sender, amount);
        vm.prank(sender);

        fTransfer.to{value: amount}(recipient);
        assertEq(recipient.balance, amount + recipientBalanceBefore);
    }

}
