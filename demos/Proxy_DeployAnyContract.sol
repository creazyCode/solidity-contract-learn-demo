//SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;




contract Proxy{
    event Deploy(address);

    receive() external payable {}

    function deploy(bytes memory _data) external payable returns (address addr){
        assembly{
            addr := create(callvalue(), add(_data, 0x20), mload(_data))
        }
        require(addr != address(0), "deploy failed");

        emit Deploy(addr);
    }

    function execute(address _target, bytes memory _data) external payable {
        (bool success, ) = _target.call{value: msg.value}(_data);
        require(success,"failed");
    }

}

contract TestContract1{
    address public owner = msg.sender;

    function setOwner(address _owner) public {
        require(msg.sender == owner, "not owner");
        owner = _owner;
    }


}

contract TestContract2{

    address public owner = msg.sender;

    uint public value = msg.value;

    uint public x;

    uint public y;

    constructor(uint _x, uint _y){
        x = _x;
        y = _y;
    }
}

contract Helper{

    function getByteCode1() external pure returns (bytes memory){
        bytes memory bytecode = type(TestContract1).creationCode;
        return bytecode;
    }

    function getByteCode2() external pure returns (bytes memory){
        bytes memory bytecode = type(TestContract2).creationCode;
        return bytecode;
    }

    function getCallData(address _owner) external pure returns(bytes memory){
        return abi.encodeWithSignature("setOwner(address)", _owner);
    }
}