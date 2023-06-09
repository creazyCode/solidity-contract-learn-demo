//SPDX-License-Identifier:MIT
pragma solidity ^0.8.14;

//函数选择器：https://www.wtf.academy/solidity-advanced/Selector
//发送调用合约交易时，msg.data 前4个字节是 selector （函数选择器）
//msg.data 是solidity中的一个全局变量，其值为完整的 calldata(调用函数的字节码)
//即：abi.encodeWithSignature("a(uint256)", var1)
//其中 a(uint256) 是函数签名：selector 即为函数签名hash值的前4位 bytes4(keccake256("mint(uint256)"))
contract FunctionSelector{

    //这里input即msg.data未：0xa0712d6800000000000000000000000000000000000000000000000000000000000000df
    function mint(uint num) public pure returns(uint) {
        return num - 1;
    }

    //这里输出结果为: 0xa0712d68
    function mintSelector() public pure returns(bytes4){
        //
        return bytes4(keccak256("mint(uint256)"));
    }
}