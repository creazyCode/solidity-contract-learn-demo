//SPDX-License-Identifier:MID
pragma solidity ^0.8.14;

import "./Demo13_EnumImport.sol";

contract DemoEnum {
     enum Status {
          Pending,
          Shipped,
          Accepted,
          Rejected,
          Canceled
     }

     Status public status;

     function get() public view returns(Status){
          return status;
     }

     function set(Status _status) public {
          status = _status;
     }

     function cancel() public {
          status = Status.Canceled;
     }

     function reset() public {
          delete status;
     }
}

contract DemoEnum2{
     Color public color;
}