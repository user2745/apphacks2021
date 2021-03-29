pragma solidity ^0.5.1;

contract Purchase {
    uint public yourFunds;

    constructor() public {
        yourFunds = 100;
    }
    
    function addFunds (uint _add) public { yourFunds + _add; }

    function makePurchase (uint _sale) public { yourFunds - _sale; }

    function getBalance () public returns(uint) { return yourFunds; }
}