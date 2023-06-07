//SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

contract DemoTest{
    
}

contract DemoPayable {

    //这里owner用payable声明，可以用于接收eth
    address payable public owner;

    //这里构造函数用payable声明，合约可以用于接收eth
    constructor() payable{
        owner = payable(msg.sender);
    }

    //这里deposit用payable声明，可以入金eth到合约
    function deposit() public  payable {

    }

    //这里没有声明payable，调用时合约余额没有变化
    function noPayable() public {

    }


    //
    function withdraw() public {
        uint amount = address(this).balance;
        //这里由于owner地址是payable，所以可以接收eth
        (bool success, ) = owner.call{value: amount}("");
        require(success, "withdraw failed");
    }

    //这里_to是payable声明的
    function transfer(address payable _to, uint amount) public {
        (bool success, ) = _to.call{value: amount}("");
        require(success, "transfer failed");
    }

    function getBalance() public view returns(uint){
        return address(this).balance;
    }


}