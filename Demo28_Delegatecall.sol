//SPDX-License-Identifier:MIT
pragma solidity ^0.8.14;

contract B {
    uint public num;
    address public sender;
    uint public value;

    function setVar(uint _num) public payable{
        num = _num;
        sender = msg.sender;
        value = msg.value;
    }

}

//通过测试结果可以发现：delegatecall修改的是合约A的value和sender , delegatecall 会修改调用者合约的storage，执行上下文是在调用者合约里；
//典型攻击案例：修改owner地址
contract A {
    uint public num;
    address public sender;
    uint public value;

    function setVar(address _contract, uint _value) public payable returns(bool) {
        (bool success, ) = _contract.delegatecall(
            abi.encodeWithSignature("setVar(uint256)", _value)
        );
        return success;
    }
}