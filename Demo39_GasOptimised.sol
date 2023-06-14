//SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

//gas优化
contract DemoGasOptimized{

    uint public total;

    //gas优化前
    //求 小于99且为偶数的 总和
    function sumNotOptimized(uint[] memory nums) external {
        for(uint i = 0; i < nums.length; i++){
            bool isEven = nums[i] % 2 == 0;
            bool isLessThan99 = nums[i] < 99;
            if(isEven && isLessThan99){
                total += nums[i];
            }
        }
    }

    //gas优化后
    function sumOptimized(uint[] calldata nums) external {
        uint _a = total;
        uint len = nums.length;

        for(uint i = 0; i < len; ){
            uint num = nums[i];
            if(num % 2 == 0 && num < 99){
                _a += num;
            }
            unchecked {
                ++i;
            }
        }

        total = _a; //如果没有这段代码，状态变量还是没修改，不需要gas，需要加view关键字
    }
}