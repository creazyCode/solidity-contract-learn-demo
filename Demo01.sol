//SPDX-License-Identifier: MID
pragma solidity ^0.8.14;

contract Demo01 {
     uint public age;
     string public name;

     function setName(string memory _name) public {
          name = _name;
     }

     function setAge(uint _age) public {
          age = _age;
     }
}