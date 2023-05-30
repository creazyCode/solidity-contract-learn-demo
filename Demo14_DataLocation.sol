//SPDC-License-Identifier:MID
pragma solidity ^0.8.14;

//数据位置，引用类型必须声明变量的数据位置
//引用类型设计的数据量较大，复制他们需要小号大量gas，非常昂贵，所以需考虑存储位置
//引用类型：
//   动态数组 ：字符串和bytes是特殊的数组，也是引用类型
//   mapping 映射
//   struct 结构体
//数据位置类型
//storage: 永久存储，成本较高
//memory: 临时数据，成本较低
//calldata: 类似memory,但数据不可修改。所有传递给函数的值都存储在该位置，calldata是外部函数的参数（非返回参数）的默认位置
//stack:
//https://cloud.tencent.com/developer/article/1161545
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