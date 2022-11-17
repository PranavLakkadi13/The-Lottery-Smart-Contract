// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0;

contract Lottery{
    address payable[] public players;
    address public manager;

    constructor(){
        manager = msg.sender;
    }

    receive() external payable{
        require(msg.value == 0.1 ether);
        players.push(payable(msg.sender));
    }

    function getBalance() public view returns(uint){
        require(msg.sender == manager,"You are not the manager");
        return address(this).balance;
    }
    //Consider this just as a proof of concept do not use it with actual money
    function random() public view returns(uint){
        return uint(keccak256(abi.encodePacked(block.difficulty , block.timestamp , players.length)));
    }

    function pickWinner() public {
        require(msg.sender == manager);
        require(players.length>=3);

        uint r = random();
        address payable winner;
        
        uint index = r % players.length;
        winner = players[index];

        winner.transfer(getBalance());
        players = new address payable[](0); //reseting the lottery
    }
}