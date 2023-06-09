//SPDX-License-Identifier:MIT
pragma solidity ^0.8.14;

//函数调用，有两种方式：
//1、简单方式，如 A.foo(x);
//2、call方式，此方式不推荐使用
contract Callee{

    uint public x;
    uint public value;

    constructor(uint _x){
        x = _x;
    }

    function setX(uint _x) public returns (uint){
        x = _x;
        return x;
    }

    function setXAndSendEther(uint _x) public payable returns (uint, uint){
        x = _x;
        value = msg.value;
        return (x, value);
    }
}

contract Caller {
    function call1(address _callee, uint _x) public {
        Callee callee = Callee(_callee);
        callee.setX(_x);
    }

    // function call2(address _callee, uint _x) public {
    //     Callee callee = new Callee(_x);
    //     callee.setX(_x);
    // }

    function call3(Callee _callee, uint _x) public {
         _callee.setX(_x);
    }

    function call4(Callee _callee, uint _x) public payable returns(uint){
        (uint x, uint value) = _callee.setXAndSendEther{value: msg.value}(_x);
        return x + value;
    }
}