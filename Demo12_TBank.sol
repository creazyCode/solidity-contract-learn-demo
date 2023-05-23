//SPDX-License-Identifier: MID
pragma solidity ^0.8.14;

contract TBank {
     address payable public owner;

     constructor() {
          owner = payable(msg.sender);
     }

     modifier ownerable(){
          require(owner == msg.sender, "only owner can withdraw");
          _;
     }

     function deposit() payable public {

     }

     function withdraw(uint amount) public payable ownerable{
          require(amount <= address(this).balance, "Insufficient balance");
          (bool result, ) = owner.call{value: amount}("");
          require(result, "withdraw failed");
     }

     function checkBalance() public view returns(uint){
          return address(this).balance;
     }

}