# Voting Smart Contract
This is a simple Ethereum smart contract for a voting system, written in Solidity. The contract allows a predefined set of proposals to be voted on by participants.
The voting period is set during the contract deployment and only one vote per address is allowed.

## Features
### Proposal Creation
Proposals are created at the time of contract deployment.
### Voting
Participants can vote for their preferred proposal before the voting period ends.
### Chairperson Role
The contract deployer is the chairperson who has special privileges, such as ending the voting period.
### Result Retrieval
The contract allows retrieving the winning proposal after the voting period has ended.
## Prerequisites
Solidity ^0.8.0
An Ethereum development environment (e.g., Remix, Truffle, Hardhat)
A wallet (e.g., MetaMask) to deploy the contract and interact with it
## Contract Structure
Proposal Struct
## description
A string describing the proposal.
### voteCount
An unsigned integer representing the number of votes the proposal has received.
## State Variables
### proposal
An array of Proposal structs, storing all proposals available for voting.
### hasVoted:
A mapping that keeps track of whether an address has voted.
### chairperson:
The address that deployed the contract, who acts as the chairperson.
### votingEnd:
A timestamp indicating when the voting period ends.
## Events
### VoteCast:
Emitted when a vote is cast, containing the voter's address and the index of the proposal voted for.
## Functions
### Constructor: Voting(string[] memory proposalDescriptions, uint votingDuration)
Initializes the contract with a list of proposal descriptions and sets the voting duration.
Sets the chairperson to the address that deployed the contract.
Calculates the votingEnd timestamp based on the current block timestamp and the provided votingDuration.
### vote(uint proposalIndex)
Allows a participant to vote for a proposal.
### Conditions:
Voting must occur before the votingEnd.
The participant must not have voted before.
The proposal index must be valid.
Emits the VoteCast event upon a successful vote.
###  getWinningProposal() public view returns (uint winningProposalIndex)
Returns the index of the proposal with the most votes.
Ensures that there is a winning proposal by using an assert statement.
### endVoting() public onlyChairperson view
Allows the chairperson to end the voting.
## Conditions:
The current time must be after the votingEnd.
Reverts the transaction with a message indicating that voting has ended and results are final.
## Usage
Deployment
Deploy the contract by passing an array of proposal descriptions and the voting duration (in seconds).
Example: ["Proposal 1", "Proposal 2", "Proposal 3"], 86400 (for 24 hours duration).
Interacting with the Contract
### Vote:
Call the vote function with the index of the proposal you want to vote for.
### Check Winning Proposal:
Use getWinningProposal to view the index of the winning proposal.
### End Voting:
The chairperson can invoke endVoting after the voting period has ended to lock in the results.
## Authors
Metacrafter Chris
@ASHWANI SINGH @ash995656@gmail.com

### License
This project is licensed under the MIT License - see the LICENSE.md file for details
