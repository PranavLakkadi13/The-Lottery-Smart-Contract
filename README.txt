The Lottery Smart Contract - Planning and Design

Lottery Algorithm:-

1. The lottery starts by accepting ETH transactions, Anyone having an Ethereum wallet can send fixed amount of 0.1 Eth
to the contract's address

2. The players who sent ETH directly to the contract's address and their Ethereum address is registered , A user can send
more transactions having more chances to win

3. There is a Manager, the account that deploys and manages the contract 

4. At some point , if there are at least 3 player, the manager can pick a random winner from the players list. Only the
manager is allowed to see the contract balance and to randomly select the winner 

5. The contract will transfer the entire balance to the winner's address and the lottery is reset and ready for the next 
round.