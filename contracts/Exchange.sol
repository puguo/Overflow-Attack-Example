// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;
import "hardhat/console.sol";


contract TokenExchange {
    mapping(address => uint8) public balances;

    event TokenTransfer(address indexed from, address indexed to, uint8 amount);

    function deposit(uint8 amount) external {
        require(amount > 0, "Amount must be greater than zero");
        balances[msg.sender] += amount;
    }

    function withdraw(uint8 amount) external {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;
    }

    function transfer(address to, uint8 amount) external {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;
        balances[to] += amount;
        emit TokenTransfer(msg.sender, to, amount);
    }

    // overflow attack can happen in this function
    function batchtransfer(address[] calldata _addrs, uint8 amount) external {
        require(_addrs.length < 10);
        uint8 length = uint8(_addrs.length);
        uint8 amounts;
        // solidity 0.8 and upper revert overflow by default, unchecked is used to moniter the situation
        // In this case, if it doesn't check for overflow, you can make amounts loop back to 0
        unchecked {
            amounts = amount * length;
        }
        console.log("The amount that should be sent to each receiver is 128. However, due to the overflow caused by 2*128, it loops back to %s", amounts);
        require(balances[msg.sender] >= amounts, "Insufficient balance");
        // It will by subtracted by overflowed amount, in our example, amounts should be 0
        balances[msg.sender] -= amounts;
        for(uint i = 0; i < length; i++) {
            balances[_addrs[i]] += amount;
            emit TokenTransfer(msg.sender,_addrs[i],amount);
            console.log("Receiver[%d] balance: %s", i+1, balances[_addrs[i]]);
        }
        console.log("Attacker balance : %s", balances[msg.sender]);
        console.log("After the third attacker transfers 128 to each of the two receivers, the account balances did not decrease and remained at 5.");
    }

    function getBalance(address account) external view returns (uint256) {
        return balances[account];
    }
}
