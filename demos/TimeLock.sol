//SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

//时间锁应用案例
//https://github.com/Web3-Club/solidity-by-example_Chinese/blob/main/01%20%E5%BA%94%E7%94%A8/%E6%97%B6%E9%97%B4%E9%94%81.md
contract DemoTimeLck{

    address payable public benefit;
    uint public unlockTime;

    constructor(address _benefit, uint _unlockTime) payable {
        require(_unlockTime > block.timestamp, "unlockTime must greater than now");
        benefit = payable(_benefit);
        unlockTime = _unlockTime;
    }

    function deposit() public payable {

    }

    function release() public {
        require(unlockTime <= block.timestamp, "release time has not arrived");

        uint balance = address(this).balance;
        benefit.transfer(balance);
    }
}