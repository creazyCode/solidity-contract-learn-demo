//SPDX-License-Identifier: MIT
pragma solidity >= 0.8.0 <= 0.8.19 ;

contract DemoError{

    //在solidity 0.4.10之前，通过if ... throw 的方式处理条件异常，但是throw会用光caller所有的gas;
    //require: 条件不满足，回退所有状态并退回gas；

    function testRequire(uint _i) public pure {
        require(_i > 10, "input must be greater than 10");
    }

    //revert 和 require 一样，适合判断条件非常复杂的场景
    function testRever(uint _i) public pure {
        if(_i <= 10){
            revert("input must be greater than 10");
        }
    }

    
    uint public num;

    //assert 用于处理函数bug即不会发生的情况(如：检查溢出，检查不变量等)通常用于函数结尾处，会用掉所有gas,不应该被经常用到
    function testAssert() public view {
        assert(num == 0);
    }

     // error 可定义在合约外部，可以被继承。调用时必须用revert
    error InsufficientBalance(uint balance, uint withdrawAmount);

    function testCustomError(uint _withdrawAmount) public view{
        uint bal = address(this).balance;
        if(bal < _withdrawAmount){
            revert InsufficientBalance({balance: bal, withdrawAmount: _withdrawAmount});
        }
    }

}

