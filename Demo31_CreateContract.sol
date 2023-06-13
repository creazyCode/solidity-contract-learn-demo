
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

//声明car合约
contract Car{

    address public owner;
    string public model;
    address public carAddr;

    constructor(address _owner, string memory _model) payable{
        owner = _owner;
        model = _model;
        carAddr = address(this);
    }
}

//本案例中：通过create创建的car1 存储在cars数组中，即Car合约实例1,通过getCar返回的状态变量为实例1中的
//通过createAndSendEth创建的car2存储在cars数组中，即Car合约实例2，通过getCar返回的余额状态变量有值
contract CarFactory{

    Car[] public cars;

    function create(address _owner, string memory _model) public {
        Car car = new Car(_owner, _model);
        cars.push(car);
    }

    function createAndSendEth(address _owner, string memory _model) public payable {
        Car car = new Car{value: msg.value}(_owner, _model);
        cars.push(car);
    }

    function getCar(uint _index) public view returns (address owner, string memory model, address carAddr, uint balance){
        Car car = cars[_index];
        return (car.owner(), car.model(), car.carAddr(), address(car).balance);
    }
}
