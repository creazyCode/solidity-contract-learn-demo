//SPDX-License-Identifier: MIT
pragma solidity >= 0.8.0 <= 0.8.19 ;

//合约构造函数以及合约继承

//基类合约
contract DemoBase{

    string public name;

    constructor(string memory _name){
        name = _name;
    }

}

contract DemoX{
    string public xname;

    constructor(string memory _xname){
        xname = _xname;
    }
}

contract DemoB is DemoBase, DemoX {
    //通过构造函数传参，给父类合约构造初始化
    //这种和 函数修饰器 modifier 非常像
    constructor(string memory _name, string memory _xname) DemoBase(_name) DemoX(_xname) {

    }
}

//通过继承父类list 传入构造初始化参数
contract DemoC is DemoBase("input from demobase"), DemoX("input from demox"){

}

//父类构造器调用顺序和继承有关，和父类合约编写代码的位置无关
contract DemoD is DemoBase, DemoX {

    constructor() DemoBase("input base") DemoX("input x"){

    }
}

contract DemoE is DemoBase,DemoX {
    constructor() DemoX("input x") DemoBase("input base"){}
}

