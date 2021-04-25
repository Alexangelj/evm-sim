pragma solidity 0.8.1;

abstract contract Agent {

  address public model;
  string public name;
  uint public id;

  constructor() {}

  function step() public virtual {}

  function advance() public virtual {}


}