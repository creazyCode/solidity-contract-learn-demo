//SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

interface IERC20 {
    function transfer(address, uint) external;
}

contract Token {
    function transfer(address a, uint b) external {}
}

//abi编码
contract DemoAbiEncode{

    function test(address _contract, bytes calldata data) external returns(bool){
        (bool ok, ) = _contract.call(data);
        return ok;
    }

    //函数签名编码
    function encodeWithSignature(address a, uint b) public pure returns(bytes memory){
        return abi.encodeWithSignature("transfer(address, uint)", a,b);
    }

    //函数选择器编码
    function encodeWithSelector(address a, uint b) public pure returns(bytes memory){
        return abi.encodeWithSelector(IERC20.transfer.selector, a,b);
    }

    function encodeWithCall(address a, uint b) public pure returns(bytes memory){
        return abi.encodeCall(IERC20.transfer,(a,b));
    }

    //encode vs encodePacked
    //encode将给定参数用abi编码，被用于和智能合约交互，每个参数通过填充0的方式转化为32字节
    //encodePacked 类似encode，但会省略0已节省空间。 用于想节省空间并不与合约交互的场景，如计算hash，计算hash会有碰撞问题
    function encodePacked(string memory a, uint b) public pure returns(bytes memory){
         return abi.encodePacked(a,b);
         //encodePacked不能直接对值进行编码，即对变量进行编码，需要指明类型
        //return abi.encodePacked(1,2);
    }

}