//SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

contract lottery {
    address payable[] public players; // creating an array 
    address payable public manager;

    constructor() {
        manager = payable(msg.sender); // to assign declare the account address of the manager
    } 

    receive() external payable { //to make the contrac recieve transactions 
        require(msg.sender != manager, "Manager can't participate");
        require(msg.value == 0.1 ether); // this condition checks that atleast 0.1ether is sent into the contract
        // ^^ if the condition is not met then the transaction will revert but the gas till there will be used 
        players.push(payable(msg.sender)); // to store all the payable addresses in the array of players since the array is for payable addresses
    }

    function getBalance() public view returns(uint) { // to get the balance 
        require(msg.sender == manager); // the condition to chech that only the manager can see the balance 
        return address(this).balance;
    }

    function random() public view returns(uint) { // this is used to create a random number but dont use on real application
        // this type of random number could be attacked so avoid it on real usecase contract 
        return uint(keccak256(abi.encodePacked(block.difficulty,block.timestamp,players.length)));
    }

    function pickwinner() public {
        require(msg.sender == manager); // only access to the manager to announce the result
        require(players.length >= 3); // atleast 3 participants should enter
        
        uint r = random();
        address payable winner;
        uint index = r % players.length; 
        
        uint num9 = getBalance() / 10; // to get 10% of the balance
        uint trans_winner = getBalance() - num9; // to get 90% of the balance
        
        
        winner = players[index];
        winner.transfer(trans_winner); // winner of the lottery gets 90% of the prize money 
        manager.transfer(num9); // manager gets 10% of the prize money 


        players = new address payable[](0); //to reset the lottery 
    }


}
