// SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;

contract Sender {
    // the factory that deployed this contract
    address private immutable _factory;

    constructor(){
        _factory = msg.sender;
    }

    function transfer(address recipient) external payable {
        // We need some protection which makes sure the implementation can't be selfdestructed
        // checking if its the original implementation requires a sload,
        // comparing the sender to an immutable address doesn't (as immutable is included in the code)
        require(msg.sender == _factory);

        // 'selfdestruct' destroys this contract and forces the recipient to accept the ETH
        // without allowing code to execute and without the possibility of a revert
        selfdestruct(payable(recipient));
    }
}
