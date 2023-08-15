//SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import "https://github.com/aave/aave-v3-core/blob/master/contracts/flashloan/base/FlashLoanSimpleReceiverBase.sol";
import "https://github.com/aave/aave-v3-core/blob/master/contracts/interfaces/IPoolAddressesProvider.sol";
import "https://github.com/aave/aave-v3-core/blob/master/contracts/dependencies/openzeppelin/contracts/IERC20.sol";

contract AAVESimpleFlashLoan is FlashLoanSimpleReceiverBase{

    address payable owner;

    constructor(address _addressProvider) FlashLoanSimpleReceiverBase(IPoolAddressesProvider(_addressProvider)){
        
    }

    /**

    */
    function fnRequestFlashLoan(address _token, uint256 _amount) public {
        address receiverAddress = address(this); // 用来接收闪电贷资金的合约地址，在这个合约中是部署合约的地址
        address asset = _token; // 闪电贷的贷款资产代币地址
        uint256 amount = _amount;  // 闪电贷的额度
        bytes memory params = "";  // 额外信息作为可变参数打包传递给receiver，暂时用不到
        uint16 referralCode = 0;

        POOL.flashLoanSimple(receiverAddress, asset, amount, params, referralCode);
    }

    /*
    * 闪电贷策略合约必须实现的函数，一般用于授权还款额度给LendPool合约地址，
        该函数是在上面的函数执行完毕之后，回调执行该函数，操作approve一定量的币(贷款+手续费)给Lending Pool地址
        手续费：借款总额的0.09%.
    */
    function executeOperation(
        address asset,
        uint256 amount,
        uint256 premium,
        address initator,
        bytes calldata params
    )external override returns(bool){
        //todo
        
        uint256 totalAmount = amount + premium;
        IERC20(asset).approve(address(POOL), totalAmount);
    }

    receive() external payable{

    }
}