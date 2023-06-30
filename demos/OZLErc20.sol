// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";

//使用openzeppelin官方库的erc20标准实现erc20 token
contract OpenZeppeLinErc20 is ERC20 {

    constructor (string memory _name, string memory _symbol) ERC20(_name,_symbol){
        _mint(msg.sender, 100 * 10 ** (decimals()));
    }
}