//SPDX-License-Identifier: MID
pragma solidity ^0.8.14;

contract LuckySeven {
     uint public targetAmount = 7 ether;
     uint public currentBalance;
     address public winner;

     function deposit() public payable{
          require(msg.value == 1, "value must equal 1 ether");
          currentBalance += msg.value;
          require(currentBalance < targetAmount, "deposit success");
          if(currentBalance == targetAmount){
               winner = msg.sender;
          }
     }

     function withdraw() public payable{
          require(msg.sender == winner, "sorry, you are not the winner");
          (bool isSuccess, ) = msg.sender.call{value: address(this).balance}("");
          require(isSuccess, "withdraw failed");
     }
}