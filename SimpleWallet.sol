// SPDX-License-Identifier: MIT

pragma solidity >=0.7.1 <0.9.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/math/SafeMath.sol";

contract Allowence is Ownable{

    using SafeMath for uint;

    mapping(address => uint) public allowence;

    event AllowenceChanged(address _forWho, address _fromWhom, uint _oldAmount, uint _newAmount);

    modifier OwnerOrAllowed(uint _amount){
        require(msg.sender == owner() || allowence[msg.sender] >= _amount,"You are not allowed");
        _;
    }
    function getBalance() public view returns(uint){
        return address(this).balance;
    }

    function addAllowence(address _who, uint _amount) public onlyOwner{
        emit AllowenceChanged(_who,msg.sender,allowence[_who], _amount);
        allowence[_who]=_amount;
    }

    function reduceAllowence(address _who,uint _amount) internal{
        emit AllowenceChanged(_who,msg.sender,allowence[_who],allowence[_who].sub(_amount));
        allowence[_who] =allowence[_who].sub(_amount);
    }
 

}

contract Wallet is Allowence{

    event MoneySent(address _beneficiary,uint _amount);
    event MoneyRecieved(address _from,uint _amount);
    
    function withDrawMoney(address payable _to,uint _amount) public OwnerOrAllowed(_amount){
        require(getBalance() >= _amount,"Contract is out of funds");
        if(msg.sender != owner()){
            reduceAllowence(msg.sender,_amount);
        }
        emit MoneySent(_to,_amount);
        _to.transfer(_amount);
    }

    receive () external payable{
        //react to recive ether
        emit MoneyRecieved(msg.sender,msg.value);
    }

    //this renounceOwnership which we got from Ownable.sol doesn't makes sence here
    function renounceOwnership() public override view onlyOwner{
        revert("Can't renounce Ownership here");
    }

    function destroySmartContract() public onlyOwner{
        selfdestruct(payable(owner()));
    }
    
}
