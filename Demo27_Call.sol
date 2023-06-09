//SPDX-License-Identifier:MIT
pragma solidity ^0.8.14;

contract Receiver{

    event recevied(address caller, uint amount, string message);

    receive() external payable {
        emit recevied(msg.sender, msg.value, "receive wal called");
    }

    fallback() external payable {
        emit recevied(msg.sender, msg.value, "fallback was called");
    }

    function foo(string memory _message, uint _x) public payable returns(uint) {
        emit recevied(msg.sender, msg.value, _message);
        return _x + 1;
    }
}


//call: 用途有2种
//1、用于转账eth ，官方推荐用这种方式
//2、用于调用其他合约（低级别调用），官方不推荐这种方式调用合约
contract Caller {

    event response(bool success, bytes data);

    function callExist(address payable _to) public payable {
        (bool success, bytes memory _data) = _to.call{value: msg.value, gas: 5000}(
            abi.encodeWithSignature("foo(string , uint)", "call foo", 11)
        );
        emit response(success, _data);
    }

    function callNotExist(address payable _to) public payable {
        (bool success, bytes memory _data) = _to.call{value: msg.value}(
            abi.encodeWithSignature("notExistFunc()", "")
        );
        emit response(success, _data);
    }

}