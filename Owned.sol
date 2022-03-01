// SPDX-License-Identifier: MIT

pragma solidity >=0.7.1 <0.9.0;

contract Owned{
    address payable public owner;
    constructor(){
        owner = payable(msg.sender);
    }

    modifier onlyOwner{
        require(msg.sender == owner,"Owner required");
        _;
    }
}

//this contract is inherited in MappingAndStructExample
