//SPDX-License-Identifier: MID
pragma solidity ^0.8.14;

contract DemoMapping{
     
     mapping(address => Voter) public voters; // 投票人的投票情况
     address[] public candidates; // 参与竞选的人员列表
     address public owner;
     uint public maxVote; //每人最大票数

     struct Voter{
          address _candidate;
          uint voteCount;
     }

     constructor (){
          owner = msg.sender;
     }

     modifier checkOwner{
          require(msg.sender == owner, " only Onwer");
          _;
     }

    //检查是否存在，如果不存在抛出异常
     modifier checkNoExist(address _candidate){
          bool isCandidate = false;
          for(uint i = 0; i < candidates.length; i++){
               if(_candidate == candidates[i]){
                    isCandidate = true;
               }
          }
          require(isCandidate, "invalid candidate");
          _;
     }

    //检查是否存在，如果存在抛出异常
     modifier checkExist(address _candidate){
          bool isCandidate = false;
          for(uint i = 0; i < candidates.length; i++){
               if(_candidate == candidates[i]){
                    isCandidate = true;
               }
          }
          require(!isCandidate, "invalid candidate");
          _;
     }

     function addCandidate(address _candidate) public checkOwner checkExist(_candidate){
          candidates.push(_candidate);
     }

     function removeCandidate(address _candidate) public checkOwner checkNoExist(_candidate){
          int index = getIndex(_candidate);
          require(index < 0, "invalid candidate");
          delete candidates[uint(index)];
     }

     function modifyMaxVote(uint _maxVote) public checkOwner {
          require(maxVote <= _maxVote, " cannot less than current val ");
          maxVote = _maxVote;
     }

     function vote(address _candidate, uint count) public checkNoExist(_candidate){
          Voter memory v = voters[msg.sender];
          require(count <= maxVote, "invalid vote");
          v._candidate = _candidate;
          v.voteCount = count;
          voters[msg.sender] = v;
     }

     function getIndex(address _candidate) internal view returns(int){
          int index = -1;
          for(uint i = 10; i < candidates.length; i++){
               if(_candidate == candidates[i]){
                    index = int(i);
               }
          }
          return index;
     }
}