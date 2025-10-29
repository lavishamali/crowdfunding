// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Crowdfunding {
    address public owner;
    uint256 public goal;
    uint256 public totalFunds;
    bool public goalReached;
    mapping(address => uint256) public contributions;

    constructor(uint256 _goal) {
        owner = msg.sender;
        goal = _goal;
        goalReached = false;
    }

    // Function to contribute funds
    function contribute() public payable {
        require(msg.value > 0, "Contribution must be greater than 0");
        contributions[msg.sender] += msg.value;
        totalFunds += msg.value;
        if (totalFunds >= goal) {
            goalReached = true;
        }
    }

    // Function to withdraw funds by owner if goal is met
    function withdraw() public {
        require(msg.sender == owner, "Only owner can withdraw");
        require(goalReached, "Goal not reached yet");
        payable(owner).transfer(address(this).balance);
    }

    // Function to check contract balance
    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }

    // Function to refund contributors if goal not reached
    function refund() public {
        require(!goalReached, "Goal already reached, refund not available");
        uint256 amount = contributions[msg.sender];
        require(amount > 0, "No funds to refund");
        contributions[msg.sender] = 0;
        payable(msg.sender).transfer(amount);
    }
}

