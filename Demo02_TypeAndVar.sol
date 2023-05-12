/*
 * @@Description: TODO
 * @@Author: tx
 * @@Date: Do not edit
 */
//SPDX-License-Identifier: MID
pragma solidity ^0.8.14;


contract TypeAndVar {
     uint8 public age1;
     //
     uint8 public age2 = type(uint8).min;
     uint8 public age3 = type(uint8).max;
     uint256 public amount;
     int public a1; 
     address public myAccount;

     //布尔类型：bool
     bool public boolV1 = true;

     //整数类型：int / uint （无符号整数类型）
     // int = int256 = 2**256 -1; uint8: 0 ~ 2**8-1
     int public intV1 = -1;
     int8 public int8V2 = 22;
     uint8 public uint8V3 = 222;
     int public intMax = type(int).max;
     int public intMin = type(int).min;
     uint public uintMax = type(uint).max;
     uint public uintMin = type(uint).min;

     uint8 public uint8Max = type(uint8).max;

     //
     address public addV1 = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;

     //定长数组
     uint8[5] public uintA85 = [1,2,3,4,5];

     //变长数组
     bytes bytesA1 = new bytes(8);
     uint8[] public uint8Arr = new uint8[](2);

     //bytes 和 string 都是变长数组，非值类型(且在calldata和memory中会被紧打包，即元素连续存在一起，不会按每32字节一单元存放)
     string public stringV1 = "abcde";
     string public stringV2 = "abcde";

     //字符串比较（solidity中没有字符串操作的函数，需要使用第三方字符库）
     bool public isStringEqual = keccak256(abi.encodePacked(stringV1)) == keccak256(abi.encodePacked(stringV2));
     string public joinString = string.concat(stringV1, stringV2);

     //类型的默认值
     uint8 public uintD1;
     uint16 public uintD16;
     address public addrD;
     

     event printSend(address pSend, uint amount, string info);

     function countArr1() public view returns (uint) {
          uint sum = 0;
          for(uint i = 0; i < uintA85.length; i++){
               sum = sum + uintA85[i];
          }
          return sum;
     }

     function push(uint8 arrVal) public  {
          uint8Arr.push(arrVal);
     }

     function setAge(uint8 _age) public {
          age1 = _age;
     }

     function getBalance() public view returns(uint) {
          return address(this).balance;
     }

     //错误的写法
     function send(uint amount1) public {
          require(address(this).balance >= amount1, "balance is not enough");
          payable(myAccount).transfer(amount1);
     }

     function transfer1() public payable {
          payable(address(this)).transfer(msg.value);
          emit printSend(msg.sender, msg.value, "transfer  receive was called");
     }

     receive() external payable {
          //     emit printSend(msg.sender, msg.value, "transfer  receive was called");
          // emit放在receive里时，出现了 The called function should be payable if you send value and the value you send should be less than 
     }

     fallback() external payable {
          
     }
}