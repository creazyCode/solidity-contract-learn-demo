// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

contract DemoModifier{

    address public ower;

    uint public x = 10;

    bool public locked;

    constructor(){
        ower = msg.sender;
    }

    modifier owner(){
        require(msg.sender == ower, "not owner");
        _;
    }

    modifier validAdd(address _addr){
        require(_addr != address(0), "invalid address");
        _;
    }

    function changeOwer(address _owner) public owner validAdd(_owner) {
        ower = _owner;
    }

    //修饰器还可以在函数结束后继续执行代码
    modifier continueM() {
        require(!locked, "locked");
        locked = true;
        _;
        locked = false;
        
    }

    function decrement(uint i) public continueM{
        x -= i;
        if(i > 1){
            decrement(i-1);
        }
    }
}