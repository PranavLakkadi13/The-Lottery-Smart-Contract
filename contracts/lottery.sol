//SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

contract lottery {
    address payable[] public players; 
    address payable public manager;

    constructor() {
        manager = payable(msg.sender); 
    } 

    receive() external payable {  
        require(msg.sender != manager);
        require(msg.value == 0.1 ether); 
        players.push(payable(msg.sender)); 
    }

    function getBalance() public view returns(uint) {  
        require(msg.sender == manager); 
        return address(this).balance;
    }

    function random() public view returns(uint) { // this is used to create a random number but dont use on real application
        // this type of random number could be attacked so avoid it on real usecase contract 
        return uint(keccak256(abi.encodePacked(block.difficulty,block.timestamp,players.length)));
    }

    function pickwinner() public {
        require(msg.sender == manager);
        require(players.length >= 3);
        
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
