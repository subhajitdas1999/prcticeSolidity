// SPDX-License-Identifier: MIT

pragma solidity >=0.7.1 <0.9.0;

contract StartStopExample {
    address payable owner;
    bool public paused;
    constructor () {
        owner = payable(msg.sender);
    }

    function sendMoney() public payable{}

    function setPaused(bool _paused) public {
        require(msg.sender == owner,"Needs Owner for this");
        paused=_paused;
    }

    function destroySmartContract() public{
        require(!paused,"Contract is currently stop");
        selfdestruct(owner);
    }

}
