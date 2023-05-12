//SPDX-License-Identifier: MID
pragma solidity ^0.8.14;

contract ImmutableContract {
     address public constant owner = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
     address public immutable IM_ADDR;
     uint public immutable IM_VALUE;

     //immutable修饰的变量类似constant常量，可以在构造器中赋值，赋值后不可被修改
     constructor(address _addr, uint _value){
          IM_ADDR = _addr;
          IM_VALUE = _value;
     }
}

contract ConstantsContract {
     address public constant CONS_ADDR = 0xbfC99F161B83f591a14E1fc13D12d7c086542774;
     uint public constant CONS_VALUE = 23424231;
}