// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Voting {
    struct Proposal {
        string description;
        uint voteCount;
    }

    Proposal[] public proposals;
    mapping(address => bool) public hasVoted;
    address public chairperson;
    uint public votingEnd;

    event VoteCast(address indexed voter, uint indexed proposalIndex);

    modifier onlyChairperson() {
        require(msg.sender == chairperson, "Only chairperson can perform this action.");
        _;
    }

    constructor(string[] memory proposalDescriptions, uint votingDuration) {
        chairperson = msg.sender;
        votingEnd = block.timestamp + votingDuration;
        
        for (uint i = 0; i < proposalDescriptions.length; i++) {
            proposals.push(Proposal({
                description: proposalDescriptions[i],
                voteCount: 0
            }));
        }
    }

    function vote(uint proposalIndex) public {
        require(block.timestamp < votingEnd, "Voting period has ended.");
        require(!hasVoted[msg.sender], "You have already voted.");
        require(proposalIndex < proposals.length, "Invalid proposal index.");

        proposals[proposalIndex].voteCount += 1;
        hasVoted[msg.sender] = true;

        emit VoteCast(msg.sender, proposalIndex);
    }

    function getWinningProposal() public view returns (uint winningProposalIndex) {
        uint winningVoteCount = 0;
        
        for (uint i = 0; i < proposals.length; i++) {
            if (proposals[i].voteCount > winningVoteCount) {
                winningVoteCount = proposals[i].voteCount;
                winningProposalIndex = i;
            }
        }

        // Ensure that there is a winning proposal
        assert(winningVoteCount > 0);
    }

     function endVoting() public onlyChairperson view {
        require(block.timestamp >= votingEnd, "Voting period has not ended yet.");
        revert("Voting has ended, results are final."); // Intentional revert to show its usage
    }
}
