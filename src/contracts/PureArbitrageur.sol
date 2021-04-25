pragma solidity 0.8.1;

import "./Agent.sol";

contract PureArbitrageur is Agent {

  struct Data {
    block: uint;
    feed: feed;
    BX1: uint;
    BY2: uint;
    stepped: bool;
  }

  Data[1000] public datas;

  uint public startBlock;
  

  constructor(
    string memory name_,
    uint id_,
    address model_
  ) {

    name = name_;
    id = id_;
    model = model_;
    startBlock = block.number;
  }

  /**
  * @notice A pure arbitrageur will swap assets in a CFMM
  *         if the output is worth more than the market
  *         value of the input.
  * @dev    This agent will arb in either direction.
  */
  function step() public {
    // get the current price of X
    uint feed = model.getFeed();
    // get the amount of X output based on 1 Y
    uint deltaX = model.getRiskyAmountOut(1e18);
    // get the amount of Y output based on 1 X
    uint deltaY = model.getRiskFreeAmountOut(1e18);
    // get the value outputs
    uint BX1 = deltaX * feed / 1e18;
    uint BY2 = deltaY;

    // init a bool to check if we step
    bool tookStep;

    // If risky swap has a greater output than the feed, do the swap
    if(BX1 >= feed) {
      model.swapToRisky();
      tookStep = true;
    } else if (BY2 >= feed) {
      model.swapToRiskFree();
      tookStep = true;
    }
    
    uint distance = block.number - startBlock;
    data[distance] = Data({
      block: block.number;
      feed: feed;
      BX1: BX1;
      BY2: BY2;
      stepped: tookStep;
    })
  }
}