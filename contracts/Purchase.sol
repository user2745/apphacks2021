pragma solidity ^0.5.1;

contract Purchase {

    uint public yourFunds;

    constructor() public {
        yourFunds = 0;
    }
    
    function addFunds (string memory _add) public {
        yourFunds + _add;
    }

    function makePurchase (string memory _sale) public {
        yourfunds - _sale;
    }

    function getBalance () public {
        return yourFunds;
    }
}