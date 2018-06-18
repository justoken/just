pragma solidity ^0.4.22;

import "oraclize";

contract Investor is usingOraclize{

  string[] service = ["github","twitter","linkedin","accreditation"]; // change with uint for performance
  mapping (string => uint) scores;
  bool eResident;

  mapping (bytes32 => bytes32) expectedId;
  mapping (bytes32 => bool) isVerification;

  function Investor(string _github, string _linkedin, string _twitter, string _eResidency) {

  }

  function prepareQuery (string userId, string service, bool proof) internal {
    if(kecca256(service) == kecca256("twitter")){
      string memory head = "html(https://twitter.com/";
      if (proof)
        string memory tail = ").xpath(//*[contains(@data-nav, 'followers')]/*[contains(@class, 'ProfileNav-value')]/text())";
      else
        string memory tail = ").xpath(//*[contains(@data-nav, 'followers')]/*[contains(@class, 'ProfileNav-value')]/text())";
    } else if(kecca256(service) == kecca256("linkedin")){
      string memory head = "html(https://linkedin.com/in/";
      if (proof)
        string memory tail = ").xpath(//*[contains(@data-nav, 'followers')]/*[contains(@class, 'ProfileNav-value')]/text())";
      else
        string memory tail = ").xpath(//*[contains(@data-nav, 'followers')]/*[contains(@class, 'ProfileNav-value')]/text())";
    } else if(kecca256(service) == kecca256("github")){
      string memory head = "html(https://twitter.com/";
      if (proof)
        string memory tail = ").xpath(//*[contains(@data-nav, 'followers')]/*[contains(@class, 'ProfileNav-value')]/text())";
      else
        string memory tail = ").xpath(//*[contains(@data-nav, 'followers')]/*[contains(@class, 'ProfileNav-value')]/text())";
    } else {
      throw;
    }
    bytes memory _userId = bytes(userId);
    bytes memory _head = bytes(head);
    bytes memory _tail = bytes(tail);
    string memory query = new string(_head.length + _userId.length + _tail.length);
    bytes memory _query = bytes(query);
    uint i = 0;
    for (uint j = 0; j < _head.length; j++)
      _query[i++] = _head[j];
    for (j = 0; j < _userId.length; j++)
      _query[i++] = _userId[j];
    for (j = 0; j < _tail.length; j++)
      _query[i++] = _tail[j];

    return query;
  }

  function __callback(bytes32 _myid, string _result) {
    if (msg.sender != oraclize_cbAddress()) throw;

    if (isVerification[_myid])
      expectedId[_myid]
    else
      scores[_service] = _result;

    delete expectedId[myid];
    delete isVerification[myid];
  }

  // start the scoring process and call oraclize with the URL
  function score(bytes32 id, string userId, string _service){

    bytes query = prepareQuery(userId,service,false);

    oraclize_setProof(proofType_TLSNotary | proofStorage_IPFS);
    bytes32 oraclizeId = oraclize_query("URL", query);
    expectedId[oraclizeId] = id;
    isVerification[oraclizeId] = false;
  }


  // start the verification process and call oraclize with the URL
  function verify(bytes32 id, string userId, string proofLocation, string service){
  //bytes32 oraclizeId = oraclize_query("html(https://twitter.com/oraclizeit/status/671316655893561344).xpath(//*[contains(@class, 'tweet-text')]/text())");
    bytes query = prepareQuery(userId,service,true);

    oraclize_setProof(proofType_TLSNotary | proofStorage_IPFS);
    bytes32 oraclizeId = oraclize_query("URL", query);
    expectedId[oraclizeId] = id;
    isVerification[oraclizeId] = true;
  }


}
