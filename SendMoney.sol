// SPDX-License-Identifier: MIT

pragma solidity >=0.7.1 <0.9.0;

contract SendMoneyExample {
    function recieveMoney() public payable{

    }
    function getBalence() public view returns(uint){
        return address(this).balance ;
    }

    function withDrawMoney() public {
        address payable to = payable(msg.sender);
        to.transfer(address(this).balance);
    }

    function withDrawMoneyTo(address payable _to) public {
        _to.transfer(address(this).balance);
    }
}
