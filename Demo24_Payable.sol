//SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

contract DemoTest{
    
}

//被payable关键字声明的（address或者function），可以接受eth，即发送交易时传入value。
//声明地址 address payable ：
//          代表该地址可以接受以太币
//          开发时需要认真考虑一个地址是否需要接受eth，即是否需要用payable声明。
//          如果一个地址没有声明payable，且向该地址转入eth时，会导致编译类型错误
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