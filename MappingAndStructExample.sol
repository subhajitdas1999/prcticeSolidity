// SPDX-License-Identifier: MIT

pragma solidity >=0.7.1 <0.9.0;

import "./Owned.sol";

//compiler now go to that file and copy the content over here. 

contract MappingAndStruct is Owned{
    struct Payment{
        uint amount;
        uint timeStamp;
    }

    struct Balance{
        uint totalBalance;
        uint numPayments;
        mapping (uint => Payment) payments;
    }

    mapping (address => Balance)  public balanceRecieved;

    function getBalance() public view returns(uint){
        return address(this).balance;
    }

    function sendMoney() public payable{
        balanceRecieved[msg.sender].totalBalance+=msg.value;
        Payment memory payment = Payment(msg.value,block.timestamp);

        balanceRecieved[msg.sender].payments[balanceRecieved[msg.sender].numPayments] = payment;
        balanceRecieved[msg.sender].numPayments++;

    }

    function withDrawMoney(address payable _to, uint amount) public{
        require(balanceRecieved[msg.sender].totalBalance >= amount,"Not enough funds");
        balanceRecieved[msg.sender].totalBalance -= amount ;
        _to.transfer(amount);
    }

    function withDrawAllMoney(address payable _to) public{
        uint etherTosend = balanceRecieved[msg.sender].totalBalance;
        balanceRecieved[msg.sender].totalBalance=0;
        _to.transfer(etherTosend);
    }

    function destroyContract() public onlyOwner{

        selfdestruct(owner);
    }
}
