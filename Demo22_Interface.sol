//SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

//interface：solidity中，接口用来接受相同规则的合约，实现可更新的智能合约
//接口中不能定义state变量，包括contants
//不能有构造函数
//不能实例化一个interface
//不能实现接口中的方法
//接口中的所有方法必须定义为外部方法
contract Counter {
    uint public count;

    function increment() external{
        count += 1;
    }
}

interface ICounter {
    
    function count() external view returns(uint);

    function increment() external ;
}

contract MyCounter{
    
    function incrementCounter(address _counter) external {
        ICounter(_counter).increment();
    }

    function getCount(address _counter) external view returns(uint) {
        return ICounter(_counter).count();
    }

}