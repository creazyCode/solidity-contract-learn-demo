// SPDX-License-Identifier: MID
pragma solidity ^0.8.14;

struct Data {
     mapping(uint => bool) flags;
}

library Set {
     
     function insert(Data storage self, uint value) public returns (bool){
          if (self.flags[value]){
               return false; //已存在
          }
          self.flags[value] = true;
          return true;
     }

     function remove(Data storage self, uint value) public returns (bool){
          if(!self.flags[value]){
               return false; // 不存在
          }
          self.flags[value] = false;
          return true;
     }

     function contains (Data storage self, uint value) public view returns (bool) {
          if(self.flags[value]){
               return true;
          }
          return false;
     }
}

contract LibrarySet {
     Data values;
     
     function register(uint value) public {
          require(Set.insert(values, value));
     }

     function isExist(uint value) public view returns (bool) {
          return Set.contains(values, value);
     }
}