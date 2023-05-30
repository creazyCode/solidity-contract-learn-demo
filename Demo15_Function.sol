
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

contract Function {

    //函数返回多个值
    function f1() public pure returns(uint, address, bool, uint){
        return (1, 0xbfC99F161B83f591a14E1fc13D12d7c086542774, true, 2);
    }

    //函数返回多个带变量名的参数
    function f2() public pure returns(uint a, bool b, uint c){
        return (1, false, 2);
    }

    function f3() public pure returns(uint a, bool b, uint c){
        a = 1;
        b = true;
        c = 2;
        return (a, b, c);
    }

    //调用函数时，可忽略返回值
    function f4() public pure returns (bool) {
        (uint a, bool b, ) = f3();
        a = a+1;
        return b;
    }

    //调用函数时，采用key-value参数结构

    function keyValue(uint x, uint y, address a, bool b) public pure  returns (uint){
    
    }

    function normalCall() public pure returns(uint) {
        return keyValue(1, 2, address(0), false);
    }

    function keyValueCall() public pure returns(uint) {
        return keyValue({b: false, a: address(0), x: 1, y: 2});
    }
}
