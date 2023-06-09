//SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

//receive
//声明：receive() external payable {...}
//通过合约接受或者转发eth, 一个合约只能有一个receive(), 必须有payable关键字， 允许modifier声明

//fallback
//声明：fallback() external payable {...}
//合约中没有任何匹配的函数可调用时：调用fallback， 最多含有一个fallback, payable是可选关键字，取决于是否需要接受eth，允许modifier

//Fallback函数和Revice函数的区别：
//Recevice函数只在合约转账时调用，
//而Fallback函数除了可以在合约转账时调用外，在合约没有函数匹配或需要像合约发送附加数据时，也调用
contract Test{

    event f1(string _a);

    uint public x;

    fallback() external {
        emit f1("f1 fallback called");
    }
}

contract TestPayable{

    event f2(string _c);

    event f3(string _d);

    receive() external payable {
        emit f2("f2 receive called");
    }

    fallback() external payable {
        emit f3("f3 fallback called");
    }
}

contract DemoCall{

    function callTest(Test test) public returns(bool b1, bool b2){
        (bool success, ) = address(test).call(abi.encodeWithSignature("notExistFunc()"));
       

        address payable testPayable = payable(address(test));

        return  (success, testPayable.send(1 wei));
    }

    function callTestPayable(TestPayable testPay) public returns(bool b1, bool b2, bool b3){

        (bool success, ) = address(testPay).call(abi.encodeWithSignature("notExistFunc()"));
  

        (bool success1, ) = address(testPay).call{value:1 gwei}(abi.encodeWithSignature("notExistFunc()"));
        

        (bool success2, ) = address(testPay).call{value:2 gwei}("");
        return (success, success1, success2);
    }
}