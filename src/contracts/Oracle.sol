pragma solidity 0.8.1;

contract Oracle {

  uint public price;

  constructor() {}

  function setPrice(uint price_) public {
    price = price_;
  }

  function peek() public view returns (uint) {
    return price;
  }
}