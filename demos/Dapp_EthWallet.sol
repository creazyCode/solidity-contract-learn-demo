//SPDX-License-Identifier: MID
pragma solidity ^0.8.14;

contract EthWallet {
     address payable public owner;

     constructor() {
          owner = payable(msg.sender);
     }

     receive() external payable{

     }

     function withdraw(uint amount) external {
          require(owner == msg.sender, "not owner");
          payable(msg.sender).transfer(amount);
     }

     //这里为什么用 external修饰函数 和 view修饰? 直接用public有什么不同？
     function getBalance() external view returns(uint balance) {
          return address(this).balance;
     }


}