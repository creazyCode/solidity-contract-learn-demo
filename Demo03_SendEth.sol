/*
 * @@Description: TODO
 * @@Author: tx
 * @@Date: Do not edit
 */
//SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

/*
* example from https://solidity-by-example.org/sending-ether/
*/
//receive 和 fallback：两个都是回调function，主要在两种情况下被使用：
//1.接受eth
//2.处理合约中不存在的函数调用(代理合约 proxy contract)

//
contract ReceiveEth {
     //两者都能被用于接受eth，触发规则如下：
     /**
     *        if(msg.data is empty)?
     *          /yes            \no
     *   if(receive exist)?     cal fallback
     *      /yes         \no
     *    call receive    call fallback
     * */

     receive() external payable {

     }

     fallback() external payable {

     }

     function getBalance() public view returns (uint) {
          return address(this).balance;
     }

}

contract SendEth {

     //通过transfer调用
     function sendViaTransfer(address payable _to) public payable {
          _to.transfer(msg.value);
     }

     //通过send调用
     function sendViaSend(address payable _to) public payable {
          bool isSuccess = _to.send(msg.value);
          require(isSuccess, "failed to send eth via send");
     }

     //通过call调用
     function sendViaCall(address payable _to) public payable {
          (bool isSuccess, bytes memory data) = _to.call{value: msg.value, gas: 2300}("");
          require(isSuccess," failed to send eth via call");
     }
}



