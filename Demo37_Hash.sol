//SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

contract DemoHash{
    function hash(string memory _text, uint num, address addr) public pure returns(bytes32){
        return keccak256(abi.encodePacked(_text, num, addr));
    }

    //使用abi.encodePacked可能会出现hash碰撞问题，如：abi.encodePacked("AA","BB") 和 abi.encodePacked("A","ABB");
    // "AA","BB": 0xe5d11b08737f5dbf924278d835533b2b1e65c2fe1b5b119c5fdd21555547b9c4
    //"A","ABB": 0xe5d11b08737f5dbf924278d835533b2b1e65c2fe1b5b119c5fdd21555547b9c4
    function collision(string memory _text, string memory _text2) public pure returns(bytes32){
        return keccak256(abi.encodePacked(_text, _text2));
    }
}