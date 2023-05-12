# Overflow-Attack-Example
This is a example for overflow attack in smart contract, created as part of course project for UW-Madison CS639-008.
To run this exmaple, you should uploade exchange.sol and attack.sol to Remix IDE, under contracts folder

To simulate the attack, you should:
1. Deploy Exchange.sol, you don't need to change any setting in any step excepts for address
2. Copy the address of deplyed Exchange.sol, deploy three attack.sol with the adress you just copied
3. Copy the addresses for the first two deplyed attack contract, use them as input for the attack function of the third 
    attack contract, the format should be ["address1","address2"], double quoatation marks and square brackets are required
4. You should see a few output, including each of the receiver balance and sender balance, sender input should not change,
    receiver input should increase by 128, as attack function tries to do a batch transfer to both of the attacks contract with 
    amount of 128, 2*128 would overflow for uint8, thus bypassing the check in token exchange contract,
    more details in code comments
