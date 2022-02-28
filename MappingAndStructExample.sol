// SPDX-License-Identifier: MIT

pragma solidity >=0.7.1 <0.9.0;

contract MappingAndStruct{
    mapping (address => uint)  public balanceRecieved;

    function getBalance() public view returns(uint){
        return address(this).balance;
    }

    function sendMoney() public payable{
        balanceRecieved[msg.sender]+=msg.value;
    }

    function withDrawAllMoney(address payable _to) public{
        uint etherTosend = balanceRecieved[msg.sender];
        balanceRecieved[msg.sender]=0;
        _to.transfer(etherTosend);
    }
}
