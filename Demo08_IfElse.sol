//SDPX-License-Identifier: MID
pragma solidity ^0.8.14;

contract DemoIfElse{
     function foo(uint input) public pure returns (uint){
          if(input > 0 && input < 10){
               return 1;
          }else if(input > 10 && input < 100){
               return 2;
          }else{
               return 0;
          }

     }

     function foo1(uint input) public pure returns(uint){
          return input >= 10 ? 1 : 2;
     }
}