//SPDX-License-Identifier: MID
pragma solidity ^0.8.14;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract BatchTransferEth {
     
     address payable public owner;

     modifier ownable(){
          require(msg.sender == owner, "not owner");
          _;
     }

     constructor() payable {
          owner = payable(msg.sender);
     }

     function getBalance() public view returns(uint256){
          return address(this).balance;
     }

     //批量转ETH给所有地址，ETH数量平均分配，调用时指定的 value 值即总的 ETH 数量
     function transferAvgEthToAll(address[] calldata _toAddresses ) payable ownable public returns (bool){
          require(_toAddresses.length > 0, "toAddresses is empty");
          require(msg.value > 0, "the amount of eth for transfer is zero");
          uint avgEth = address(this).balance / _toAddresses.length; 
          for(uint32 i = 0; i < _toAddresses.length; i++){
               payable(_toAddresses[i]).transfer(avgEth);
          }
          return true;
     }

     //批量转ETH给所有地址，ETH 指定分配
     function transferDiffEthToAll(
          address payable[] calldata _toAddresses, 
          uint256[] calldata _values
          ) payable ownable public returns (bool){
          require(_toAddresses.length > 0, "toAddresses is empty");
          require(_toAddresses.length <= _values.length, "values invalid");
          uint256 totalAmount = getSum(_values);
          require(msg.value >= totalAmount, "eth not enough");
          for(uint32 i = 0; i < _toAddresses.length; i++){
               _toAddresses[i].transfer(_values[i]);
          }
          return true;
     }

     //给当前合约授权erc20 token转账的数量
     function approve(address _token, uint256 amount) ownable public returns(bool){
          IERC20 token = IERC20(_token);
          return token.approve(address(this), amount);
     }

     // erc20 token 一对多批量转账，平均计算 token 数量
     function transferAvgERC20ToAll(
          address _token, 
          address payable[] calldata _toAddresses, 
          uint256 _amount
          ) ownable public returns(bool){
          require(_toAddresses.length > 0, "invalid receiver");
          require(_amount > 0, "invalid token amount");
          //检查发送方是否给当前合约授权足够数量的erc20 token
          IERC20 token = IERC20(_token);
          require(token.allowance(msg.sender, address(this)) >= _amount, "need to approve");
          //计算每个地址转账的平均数量
          uint256 avgAmount = _amount / _toAddresses.length;
          for(uint32 i = 0; i < _toAddresses.length; i++){
               token.transferFrom(msg.sender, _toAddresses[i], avgAmount);
          }
          return true;
     }

     // erc20 token 一对多批量转账，指定 token 数量
     function transferDiffERC20ToAll(
          address _token, 
          address payable[] calldata _toAddresses, 
          uint256[] calldata _values
          ) ownable public returns(bool){
          require(_toAddresses.length > 0, "invalid receiver");
          require(_values.length >= _toAddresses.length , "invalid values");
          uint256 sum = getSum(_values);
          IERC20 token = IERC20(_token);
          require(token.allowance( msg.sender , address(this)) >= sum, "need to approve");
          for(uint32 i = 0; i < _toAddresses.length; i++){
               token.transferFrom(msg.sender, _toAddresses[i], _values[i]);
          }
          return true;
     }

     function getSum(uint256[] calldata _amountArr) public pure returns(uint256 sum){
          for(uint32 i = 0; i < _amountArr.length; i++){
               sum = sum + _amountArr[i];
          }
     }

}