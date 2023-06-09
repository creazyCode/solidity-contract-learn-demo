//SPDX-License-Identifier:MIT
pragma solidity ^0.8.14;

//Receive
contract Fallback{

    event log(string func, uint gas);

    receive() external payable {
        emit log("receive", gasleft());
    }

    fallback() external payable {
        emit log("fallback", gasleft());
    }

    function getBalance() public view returns(uint){
        return address(this).balance;
    }
}

contract SendToFallback{

    function transferToFallback(address payable _to) public payable  {
        _to.transfer(msg.value);
    }

    function callFallback(address payable _to) public payable{
        (bool success, ) = _to.call{value: msg.value}("");
        require(success, "call failed");
    }

    function callFallback2(address payable _to) public returns(bool){
        (bool success, ) = _to.call(abi.encodeWithSignature("myFunc()",""));
        return success;
    }
}