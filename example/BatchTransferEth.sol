//SPDX-License-Identifier: MID
pragma solidity ^0.8.14;

contract BatchTransferEth {
     
     address payable public owner;

     modifier ownable(){
          require(msg.sender == owner, "not owner");
          _;
     }

     constructor() payable {
          owner = payable(msg.sender);
     }

     function getBalance() public returns(uint256){
          return address(this).balance;
     }

     //批量转ETH给所有地址，ETH数量平均分配，调用时指定的 value 值即总的 ETH 数量
     function transferAvgEthToAll(address[] calldata _toAddresses ) payable ownable public returns (bool){
          require(_toAddresses.length > 0, "toAddresses is empty");
          uint avgEth = address(this).balance / _toAddresses.length; 
          for(uint32 i = 0; i < _toAddresses.length; i++){
               payable(_toAddresses[i]).transfer(avgEth);
          }
          return true;
     }

     //批量转ETH给所有地址，ETH 指定分配
     function transferDiffEthToAll(address[] calldata _toAddresses, uint256[] calldata values) payable ownable public returns (bool){
          require(_toAddresses.length > 0, "toAddresses is empty");
          require(_toAddresses.length <= values.length, "values invalid");
          for(uint32 i = 0; i < _toAddresses.length; i++){
               payable(_toAddresses[i]).transfer(values[i]);
          }
          return true;
     }

     
}