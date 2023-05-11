//SPDX-License-Identifier: MID
pragma solidity ^0.8.14;

contract UintOfSolidity {
     // 货币单位 : 1 gwei = 1e9 wei , 1 ether = 1e18 wei;
     uint public amount = 1;
     bool public isOneWei = 1 == 1 wei;
     bool public isOneGWei1 = 1 gwei == 1e9 wei;
     bool public isOneEth = 1 ether == 1e18 wei;
     bool public isOneEth1 = 1 ether == 1e9 gwei;

     // 时间单位
     uint public time = 1;
     bool public isOneSec = 1 == 1 seconds;
     bool public isOneMin = 60 seconds == 1 minutes;
     bool public isOneHour = 60 minutes == 1 hours;
     bool public isOneDay = 24 hours == 1 days;
}