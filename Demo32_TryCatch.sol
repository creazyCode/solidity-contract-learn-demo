
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

// try catch

contract DemoTryCatch{

   address public owner;

   constructor(address _owner){
       require(address(0) != _owner, "wrong addresss");
       if(_owner == 0x0000000000000000000000000000000000000001){
           revert("wrong address 0x0001");
       }
       owner = _owner;
   }

   function func1(uint _x) external  pure returns(string memory){
       require(_x != 0, "value must gretter than zero");
       return "func1 was called";
   } 
}

//用于外部函数external或者constructor
//声明形式 try Contract.func1(uint a, address b) returns(uint m, string memory n) catch (bytes memory a) or Error(string memory b) or {}

//try new Contract(uint a) catch (bytes memory a) or Error(string memory b) or {}
contract Call1{

    event logString(string message);
    event logBytes(bytes data);

    DemoTryCatch public tryCatch;

    constructor(address _owner){
        tryCatch = new DemoTryCatch(_owner);
    }

    function tryCatchFunc1(uint _x) public  {
        try tryCatch.func1(_x) returns(string memory a) {
            emit logString(a);
        }catch{
            emit logString(" call func1 failed");
        }
    }

    function tryCatchConstructor(address _owner) public {
        try new DemoTryCatch(_owner) {
            emit logString("demo create");
        }catch (bytes memory reason){
            emit logBytes(reason);
        }catch Error(string memory result){
            emit logString(result);
        } 
    }

}