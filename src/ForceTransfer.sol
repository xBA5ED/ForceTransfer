// SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;

import "@openzeppelin/contracts/proxy/Clones.sol";
import "./Sender.sol";

contract ForceTransfer {
    // Address of the implementation to clone
    address public immutable _impl;

    constructor() {
        _impl = address(new Sender());
    }

    /**
        @notice forwards the send ETH to the 'recipient' using the selfdestruct opcode
        @param recipient address to receive the ether
    */
    function to(address recipient) external payable {
        Sender _sender = Sender(Clones.clone(_impl));
        _sender.transfer{value: msg.value}(recipient);
    }
}
