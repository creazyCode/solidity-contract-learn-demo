//SPDX-License-Identifier:MID
pragma solidity ^0.8.14;

contract Array1 {

     uint[] public arr1;
     uint[] public arr2 = [11,12,13,14,15];
     uint[10] public arr3;

     function get(uint index) public view returns (uint) {
          return arr1[index];
     }

     function getArr() public view returns (uint[] memory){
          return arr1;
     }

     function push(uint i) public {
          // 在数组末尾添加一个元素
          arr1.push(i);
     }

     function pop() public {
          //删除数组最后一个元素
          //数组长度会减1
          arr1.pop();
     }

     function getLength() public view returns(uint) {
          return arr1.length;
     }

     function remove(uint i) public {
         //初始化数组某个元素，此案例中元素变为0
         //数组长度不变
          delete arr1[i];
     }

     function removeArr() public {
         //删除整个数组，长度变为0
          delete arr1;
     }

}

//删除数组某一个元素
/** 思路：遍历数组将该元素放到数组末尾，然后pop();比较费gas */
contract ArrayRemove {
    uint[] public arr;

    function push(uint i) public {
        arr.push(i);
    }

    function remove(uint _index) public {
        require(_index < arr.length, "index out of bound");
        for(uint i = _index; i < arr.length -1; i++){
            arr[i] = arr[i+1];
        }
        arr.pop();
    }
}

contract ArrayRemoveFromEnd {
    uint[] public arr;

    function remove(uint _index) public {
        require(_index < arr.length, "index out of bound");
        arr[_index] = arr[arr.length - 1];
        arr.pop();
    }
}