//SPDC-License-Identifier:MID
pragma solidity ^0.8.14;

//数据位置，引用类型必须声明变量的数据位置
//引用类型：
// 动态数组 ：字符串和bytes是特殊的数组，也是引用类型
// mapping 映射
// struct 结构体
contract DemoDataLocation {

     uint[] public arr;

     mapping(uint => address) map;

     struct DemoStruct{
          uint age;
          string name;
     }

     function f() public {

     }

     function _f(
          uint[] storage _arr,
          mapping(uint => address) storage _map,
          DemoStruct storage _struct
     ) internal {

     }

     function g(uint[] memory _arr) public returns(uint[] memory){

     }

     function h(uint[] calldata _arr) external{
          
     }

}