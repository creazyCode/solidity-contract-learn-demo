//SPDX-License-Identifier: MID
pragma solidity ^0.8.14;
contract DemoLoop{
     function sumF(uint top) public pure returns (uint){
          uint sum = 0;
          for(uint i = 0; i < top; i++){
               sum += i;
          }
          return sum;
     }

     function findRangeIndex(uint param) public pure returns(bool){
          uint index = 0;
          bool range = false;
          while(index < 100){
               if(param == index){
                    range = true;
               }
               index ++;
          }
          return range;
     }
}