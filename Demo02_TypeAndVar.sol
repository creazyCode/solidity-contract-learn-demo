/*
 * @@Description: TODO
 * @@Author: tx
 * @@Date: Do not edit
 */
//SPDX-License-Identifier: MID
pragma solidity ^0.8.14;


contract TypeAndVar {
     uint8 public age1;
     //
     uint8 public age2 = type(uint8).min;
     uint8 public age3 = type(uint8).max;
     uint256 public amount;
     int public a1; 
     address public myAccount;

     event printSend(address pSend, uint amount, string info);

     function setAge(uint8 _age) public {
          age1 = _age;
     }

     function getBalance() public view returns(uint) {
          return address(this).balance;
     }

     //错误的写法
     function send(uint amount1) public {
          require(address(this).balance >= amount1, "balance is not enough");
          payable(myAccount).transfer(amount1);
     }

     function transfer1() public payable {
          payable(address(this)).transfer(msg.value);
          emit printSend(msg.sender, msg.value, "transfer  receive was called");
     }

     receive() external payable {
          //     emit printSend(msg.sender, msg.value, "transfer  receive was called");
          // emit放在receive里时，出现了 The called function should be payable if you send value and the value you send should be less than 
     }

     fallback() external payable {
          
     }
}