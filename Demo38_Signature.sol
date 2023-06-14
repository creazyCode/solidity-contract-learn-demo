//SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

contract DemoSignature {

    function getMsgHash(address _to, uint _amount, bytes memory _message, uint _nonce) public pure returns(bytes32){
        return keccak256(abi.encodePacked(_to, _amount, _message, _nonce));
    }

    function getEthMessageHash(bytes32 msgHash) public pure returns (bytes32){
        return keccak256(abi.encodePacked("\x19Ethereum Signed Message:\n32", msgHash));
    }

    function splitSignature(bytes memory sig) public pure returns(bytes32 r, bytes32 s, uint8 v){
        require(sig.length == 65,"invalid signature length");
        //assembly : 内联汇编指令
        assembly {

            //前32位字节
            r := mload(add(sig,32))

            //后32位字节
            s := mload(add(sig,64))

            //最后一位
            v := byte(0, mload(add(sig, 96)))
        }
    }

    function recoverSigner(bytes32 _ethSignedHash, bytes memory _signature) public pure returns(address){
        (bytes32 r, bytes32 s, uint8 v) = splitSignature(_signature);
        return ecrecover(_ethSignedHash, v, r, s);

    }

    function verify(address _signer, address _to, uint _amount, bytes memory _message, uint _nonce, bytes memory signature) public pure returns(bool){
        bytes32 messageHash = getMsgHash(_to, _amount, _message, _nonce);
        bytes32 ethSignHash = getEthMessageHash(messageHash);
        return _signer == recoverSigner(ethSignHash, signature);
    }
}