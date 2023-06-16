// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

contract MultiSignDataTest{

    uint public i;

    function callF1(uint j) external {
        i += j;
    }

    function getData() public pure returns(bytes memory){
        return abi.encodeWithSignature("callF1(uint)", 12);
    }
}