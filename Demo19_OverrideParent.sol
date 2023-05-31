//关于重写（override / overwrite）父类属性

contract DemoBase{
    string public name = "this is demo base";

    function getName() public view returns(string memory){
        return name;
    }

}

//此写法在0.6.0后被废弃，编译会出错
// contract DemoC is DemoBase{
//     string public name = "this is from c";
// }

//正确重载写法
//virtual 是什么？
contract DemoD is DemoBase {
    constructor(){
        name = "this is from D";
    }
}