//SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

//库：可以理解为一些通用方法的集合，只用部署一次 供不同合约反复使用，
//库不能有状态变量；
//不能继承或者被继承；
//不能接受以太币；
//不能销毁一个库；

library Math {

    function sqrt(uint y) internal pure returns(uint z){
        if(y > 3){
            z = y;
            uint x = y / 2 + 1;
            while( x < z){
                z = x;
                x = (y / x + x) / 2;
            }
        }else if(y != 0){
            z = 1;
        }
    }

}

contract DemoLibrary{
    function testSqueareRoot(uint x) public pure  returns(uint){
        return Math.sqrt(x);
    }
}

//库也可以给数据类型添加成员变量
library Array{
    function remove(uint[] storage arr, uint index) public {
        require(arr.length > 0, "can't remove from empty array");
        arr[index] = arr[arr.length - 1];
        arr.pop();
    }
}

contract DemoLibrary2{
    using Array for uint[]; //声明类型
    uint[] public arr;

    function testArr(uint _index) public{
        arr.remove(_index);
    }

    function push(uint _element) public {
        arr.push(_element);
    }
}