pragma solidity ^4.0.22;

contract Settings {

  mapping (string => uint) values;

  function Settings() {
    values['identityMethod'] = 0; //0: nothing, 1: KYC + accr, 2: estonian e-residency, 3: custom
    values['initialPhaseMethod'] = 1; // 0: nothing, 1: iico, 2: reverse dutch auction
  }

  function updateValue(string name, uint value) {
    //assert(kecca256(name) == kecca256('identityMethod') || kecca256(name) == kecca256('initialPhaseMethod'));
    values[name] = value;
  }

}
