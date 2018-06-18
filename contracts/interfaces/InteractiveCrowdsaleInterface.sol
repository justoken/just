import "../InteractiveCrowdsaleLib.sol";

contract InteractiveCrowdsaleInterface{

  function init(InteractiveCrowdsaleLib.InteractiveCrowdsaleStorage storage, address, uint256[], uint256, uint256,uint256, uint256, uint8, string, string, uint8, bool);
  function numDigits(InteractiveCrowdsaleLib.InteractiveCrowdsaleStorage storage, uint256);
  function calculateTokenPurchase(InteractiveCrowdsaleLib.InteractiveCrowdsaleStorage storage, uint256, uint256);
  function getCurrentBonus(InteractiveCrowdsaleLib.InteractiveCrowdsaleStorage storage);
  function submitBid(InteractiveCrowdsaleLib.InteractiveCrowdsaleStorage storage, uint256, uint256, uint256);
  function withdrawBid(InteractiveCrowdsaleLib.InteractiveCrowdsaleStorage storage);
  function finalizeSale(InteractiveCrowdsaleLib.InteractiveCrowdsaleStorage storage);
  function launchToken(InteractiveCrowdsaleLib.InteractiveCrowdsaleStorage storage);
  function setCanceled(InteractiveCrowdsaleLib.InteractiveCrowdsaleStorage storage);
  function retreiveFinalResult(InteractiveCrowdsaleLib.InteractiveCrowdsaleStorage storage);
}
