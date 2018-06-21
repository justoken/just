pragma solidity ^4.0.22;

import "interfaces/SchedulerInterface.sol";
import "interfaces/InteractiveCrowdsaleInterface.sol";
import "interfaces/iudexAPI.sol";

import "Milestones.sol";
import "Settings.sol"

import "smarttoken/SmartToken.sol";
import "Storage.sol";

contract JUSToken is SmartToken {

  //deployables
  BancorConverter converter;
  Storage storage;
  InteractiveCrowdsaleInterface interactive;
  Settings settings;
  Milestones milestones;

  SchedulerInterface scheduler =  address(0x6c8f2a135f6ed072de4503bd7c4999a1a17f824b);

  uint startDate;
  uint endDate;
  address[] participants;

  mapping (string => bool) status;

  function JUSToken (
    address _converter,
    address _scheduler,
    address _interactive,
    address _storage
    ) public {

    converter = BancorConverter(_converter);    // [just <> dai bnt] broker
    scheduler = SchedulerInterface(_scheduler); //timer address
    interactive = InteractiveCrowdsaleLib(_interactive);    //iico library address
    storage = Storage(_storage);  //storage service

    settings = new Settings();
    milestones = new Milestones();

  }

  function runKYC(uint until) public {
    assert(!status['KYCrun']);

    status['registerInvestors'] = true;

    uint[3] memory uintArgs = [
        200000,      // the amount of gas that will be sent with the txn.
        0,           // the amount of ether (in wei) that will be sent with the txn
        lockedUntil  // the first block number on which the transaction can be executed.
    ];

    bytes callData = 0x12345; // TODO: ABI signature of assignCaps

    scheduler.scheduleTransaction.value(... ether)(address(this),callData,255,uintArgs);
  }

  function assignCaps(args ... , uint until) public {
    status['registerInvestors'] = false;
    assert(!status['ph1Run']);

    if(settings.values['initialPhaseMethod'] == 0){
          //nothing
    } else if(settings.values['initialPhaseMethod'] == 1){
      interactive.init(args ... );
    } else if(settings.values['initialPhaseMethod'] == 2){
      //TBD inverse dutch auction
    }

    status['ph1Complete'] = true;

    bytes callData = 0x12612323; // TODO: run PH2
    scheduler.scheduleTransaction.value(... ether)(address(this),callData,255,uintArgs);
  }

  function persistentBallot() public {
      //ballot + release

      if(finalizeEarly || noMoreFunds || scam){  //either out of money or trust
        status['ph2Complete'] = true;
        if(scam) getETHBack();
        if(finalizeEarly) giveMissingETH();
      }else{
        bytes callData = 0x12612323; // TODO: run voting next month
        scheduler.scheduleTransaction.value(... ether)(address(this),callData,255,uintArgs);
      }

  }

  function addTokenHolder(string _github, string _twitter) public payable{
    assert(status['registerInvestors']);
    if(storage.investors[msg.sender] == 0)
      storage.addInvestor(msg.sender,_github,_twitter);
    if(participants[msg.sender] == 0)
      participants.push(msg.sender);
  }




}
