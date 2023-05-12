//SPDX-License-Identifier: MID
pragma solidity ^0.8.14;

//indexed 关键字

contract EventIndexed {
     event transfer(address indexed from, address indexed to, uint amount);

     mapping(address => uint) public balances;

     address public owner;

     constructor(){
          owner = msg.sender;
     }

     function deposit(uint amount) public {
          require(msg.sender == owner, "not owner");
          balances[msg.sender] += amount;
     }

     function transferTo(address to, uint amount) public {
          require(balances[msg.sender] >= amount, "balance not enough");
          balances[msg.sender] -= amount;
          balances[to] += amount;

          emit transfer(msg.sender, to, amount);
     }

     receive() external payable {

     }
}