//SPDX-License-Identifier:MIT
pragma solidity ^0.8.17;

//多签钱包
contract MultiSignWallet{

    event deposit(address indexed sender, uint amount, uint balance);

    event submit(
        address indexed owner, 
        uint indexed txIndex,
        address indexed to,
        uint value,
        bytes data
        );

    event confirm(
        address indexed owner,
        uint indexed txIndex
    );

    event excute(
        address indexed owner,
        uint indexed txIndex
    );

    event revoke(
        address indexed owner,
        uint indexed txIndex
    );

     struct Transaction {
        address to;
        uint value;
        bytes data;
        bool executed;
        uint confirmNums;
    }

    //多签地址集
    address[] public owners;

    //是否多签地址
    mapping(address => bool) public isOwner;

    //最小签名数量
    uint public minNums;

    //交易列表
    Transaction[] public txs;

    //账户签名确认交易清单
    mapping(uint => mapping(address => bool)) public confirmedTx;

    modifier onlyOwner() {
        require(isOwner[msg.sender], "only owner");
        _;
    }

    modifier txExist(uint _txIndex){
        require(_txIndex < txs.length, "tx doesn't exist");
        _;
    }

    modifier notConfirmed(uint _txIndex){
        require(!confirmedTx[_txIndex][msg.sender], "tx already confirm");
        _;
    }

    modifier notExcuted(uint _txIndex){
        require(!txs[_txIndex].executed , "tx has executed");
        _;
    }


    //初始化 多签账户
    constructor(address[] memory _owners, uint _ownerNums){
        require(_owners.length > 0, "owners required");
        if(!(_ownerNums > 0 && _ownerNums <= _owners.length)){
            revert("invalid number of required confirmations");
        }
        for(uint i = 0; i < _owners.length; i++){
            address owner = _owners[i];
            require(address(0) != owner, "invalid owner");
            require(!isOwner[owner],"owner exist");
            
            isOwner[owner] = true;
            owners.push(owner);
        }
        minNums = _ownerNums;
    }

    receive() external payable {
        emit deposit(msg.sender, msg.value, address(this).balance);
    }

    //提交交易
    function submitTx(
        address _to,
        uint _amount,
        bytes memory _data
    ) public onlyOwner{
        uint txIndex = txs.length;
        txs.push(Transaction({
            to:_to,
            value:_amount,
            data: _data,
            executed: false,
            confirmNums: 0
        }));
        emit submit(msg.sender, txIndex, _to, _amount, _data);
    }

    //确认交易
    function confirmTx(uint _txIndex) public onlyOwner txExist(_txIndex) notConfirmed(_txIndex) {
        Transaction storage transaction = txs[_txIndex];
        transaction.confirmNums += 1;
        confirmedTx[_txIndex][msg.sender] = true;
        emit confirm(msg.sender, _txIndex);
    }

    //撤销确认
    function revokeTx(uint _txIndex) public onlyOwner txExist(_txIndex) {
        Transaction storage transaction = txs[_txIndex];
        require(confirmedTx[_txIndex][msg.sender], "transaction doedn't confirm");
        transaction.confirmNums -= 1;
        confirmedTx[_txIndex][msg.sender] = false;
        emit revoke(msg.sender, _txIndex);
    }

    //执行交易
    function executeTx(uint _txIndex) public onlyOwner txExist(_txIndex) notExcuted(_txIndex) {
        Transaction storage transaction = txs[_txIndex];
        require(transaction.confirmNums >= minNums, "cann't excute tx");

        transaction.executed = true;
        (bool ok, ) = transaction.to.call{value: transaction.value}(transaction.data);

        require(ok, "excute failed");
        emit excute(msg.sender, _txIndex);
    }

    function getOwners() public view returns(address[] memory ){
        return owners;
    }

    function getTx(uint _txIndex) public view txExist(_txIndex) returns(address to, uint value, bytes memory data, bool executed, uint confirmNums){
        Transaction storage transaction = txs[_txIndex];
        return (
            transaction.to,
            transaction.value,
            transaction.data,
            transaction.executed,
            transaction.confirmNums
            );
    }

    function getTxsCount() public view returns(uint){
        return txs.length;
    }
}