// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Crowdfunding {
    address public owner;
    uint256 public goal;
    uint256 public totalFunds;

    constructor(uint256 _goal) {
        owner = msg.sender;
        goal = _goal;
    }

    // Function to contribute to the campaign
    function contribute() public payable {
        require(msg.value > 0, "Contribution must be greater than 0");
        totalFunds += msg.value;
    }

    // Function to withdraw funds by owner if goal is met
    function withdraw() public {
        require(msg.sender == owner, "Only owner can withdraw");
        require(totalFunds >= goal, "Funding goal not reached");
        payable(owner).transfer(address(this).balance);
    }
}

