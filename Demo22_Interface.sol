//SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

//interface：solidity中，接口用来接受相同规则的合约，实现可更新的智能合约
//接口中不能定义state变量，包括contants
//不能有构造函数
//不能实例化一个interface
//不能实现接口中的方法
//接口中的所有方法必须定义为外部方法
//接口可以继承
contract Counter {
    //这里count 为public属性，有默认的count()方法
    uint public count;

    function increment() external{
        count += 1;
    }
}


interface ICounter {
    
    function count() external view returns(uint);

    function increment() external ;
}

//Counter实现了count()和increment()方法
contract MyCounter{
    //通过传入实现接口的合约地址，调用接口函数
    function incrementCounter(address _counter) external {
        ICounter(_counter).increment();
    }

    function getCount(address _counter) external view returns(uint) {
        return ICounter(_counter).count();
    }

}