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

     //批量转ETH给所有地址，数量平均分配，调用时指定的 value 值即总的 ETH 数量
     function batchTransferETHToAll(address[] calldata _toAddresses ) payable ownable public returns (bool){
          require(_toAddresses.length > 0, "toAddresses is empty");
          uint avgEth = address(this).balance / _toAddresses.length; 
          for(uint32 i = 0; i < _toAddresses.length; i++){
               payable(_toAddresses[i]).transfer(avgEth);
          }
          return true;
     }
}