// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MessageDropper {
    event MessageDropped(address indexed sender, string msg);

    function drop(string calldata _msg) public {
        emit MessageDropped(msg.sender, _msg);
    }
}
