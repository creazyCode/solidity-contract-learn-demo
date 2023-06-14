//SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

//算术运算的截断模式(unchecked) 和 检查模式(checked)
//即在发生溢出的情况(上溢或者下溢)，通过unchecked会进行截断，不会发生失败异常；
//默认情况下，算数使用的是checked模式即检查模式，如果发生溢出则抛出异常
contract DemoUncheckMath{

    //检查模式：传入参数 254，2发生异常
    function add(uint8 x, uint8 y) external pure returns(uint8){

        return x+y;

    }

    //不检查模式：传入参数254，2，返回0
    function addUnchecked(uint8 x, uint8 y) external pure returns(uint8){
        unchecked{
            return x+y;
        }
    }

    //检查模式：传入0，255  发生异常
    function sub(uint8 x, uint8 y) external pure returns(uint8){
        return x-y;
    }

    //不检查模式：传入0，255 返回1
    function subUnchecked(uint8 x, uint8 y) external pure returns(uint8){

        unchecked{
            return x-y;
        }
    }
}