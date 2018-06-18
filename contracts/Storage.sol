pragma solidity ^4.0.22;

import "Investor.sol";

contract Storage {

  mapping (address => Investor) investors;

  function Storage(address _oracle){
    OAR = _oracle;
  }

  function addInvestor(address a, string _github, string _linkedin, string _twitter, string _eResidency) {
    Investor i = new Investor(_github,_linkedin,_twitter,_eResidency);

    /*
      oraclize_query("URL", 'html(https://github.com/m4g0).xpath(//*[contains(@title, "Repositories")]//*[contains(@class, "Counter")]/text())');
      oraclize_query("URL", "json(https://gist.githubusercontent.com/"+user+"/raw/test).result.code");
    */

    investors[a] = i;
  }

}
