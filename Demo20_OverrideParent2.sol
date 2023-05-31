//SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <=0.9.0;


//关于重写父类方法
// is 继承关键字：可以继承父类所有非private 的东西
//virtual: 声明函数可以被重写
//override：声明函数为重写函数，重写的函数出入参不能变
contract A {
    
    event log(string msg);

    function f1() public virtual {
        emit log("from A f1");
    }

    function f2() public virtual {
        emit log("from A f2");
    }
}

contract B is A{

    function f1() public virtual override {
        emit log("from B f1");
        A.f1();
    }

    function f2() public virtual override{
        emit log("from B f2");
        super.f2();
    }
}

contract C is A{

    function f1() public virtual override{
        emit log("from C f1");
        A.f1();
    }

    function f2() public virtual override {
        emit log("from C f2");
        super.f2();
    }
}

//这里通过logs可以发现
//执行f1(): 显示调用了C一次 然后调用了A一次
//执行f2(): 显示调用了C一次，然后调用了B一次，最后调用了A一次
//因为通过super
contract D is B, C{

    function f1() public override(B, C){
        super.f1();
    }

    function f2() public override(B, C){
        super.f2();
    }
}
