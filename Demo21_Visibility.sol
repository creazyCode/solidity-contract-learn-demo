//SPDX-License-Identifier:MIT
pragma solidity ^0.8.14;

//public: 所有可见，状态变量会自动创建访问器getXXX()
//private: 函数和状态变量只能在本合约里访问或调用
//internal: 函数和状态变量只能在本合约和继承合约里访问或调用，不能用this
//external: 函数可被外部合约或交易访问和调用，通过this关键字,内部不能调用
contract DemoVisibility {

    function privateFunc() private pure returns(string memory){
        return "private function called";
    }

    function testPrivateFunc() public pure returns(string memory){
        return privateFunc();
    }

    function internalFunc() internal pure returns(string memory){
        return "internal function called";
    }

    function testInternalFunc() external pure returns(string memory){
        return internalFunc();
    }

    function publicFunc() public pure returns(string memory){
        return "public function called";
    }

    function externalFunc() external pure returns(string memory){
        return "external function called";
    }

    //external修饰的函数只能被外部调用，这里编译会报错
    // function testExternalFunc() public pure returns(string memory){
    //     return externalFunc();
    // }


}

contract Child is DemoVisibility {

    //private修饰的函数只能被本合约调用，这里编译会报错
    // function testPrivateFunc() public pure returns(string memory){
    //     return privateFunc();
    // }

    function testInternalFunct() public pure  returns(string memory){
        return DemoVisibility.internalFunc();
    }
}