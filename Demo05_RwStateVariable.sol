//SPDX-License-Identifier: MID
pragma solidity ^0.8.14;

contract RwStateVariable {
     uint public num;

     function set(uint _num) public {
          num = _num;
     }

     function get() public view returns (uint){
          return num;
     }
}