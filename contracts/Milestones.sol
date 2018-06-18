pragma solidity ^4.0.22;

contract Milesones {

  mapping (uint => Milestone) list;

  struct Milestone {
      uint id;
      uint value; // value released on completion (tap like)
      string description;
      string result;
      bool expired;
      uint startTime;
      uint finishTime;
  }

  function Milestones() {}

  function Milestones(Milestone[] m) {
    for(uint i=0;i<m.length;i++){
      uint id = m[i].id;
      list[id] = m[i];
    }
  }

  function addMilestones(Milesone[] m) public ownerOnly {
    for(uint i=0;i<m.length;i++){
      uint id = m[i].id;
      list[id] = m[i];
    }
  }

  function startMilestone (uint id) {
    list[id].startTime = now;
  }

  function editMilestone(uint id, string desc, uint val) {
    assert(!startTime);
    list[id].description = desc;
    list[id].value = val;
  }

  function finishMilestone (uint id) {
    list[id].finishTime = now;
  }

}
