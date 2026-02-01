// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract SimpleDAO {
    struct Proposal {
        uint256 id;
        address proposer;
        string description;
        uint256 votesFor;
        uint256 votesAgainst;
        uint256 endTime;
        bool executed;
    }

    IERC20 public governanceToken;
    mapping(uint256 => Proposal) public proposals;
    mapping(uint256 => mapping(address => bool)) public hasVoted;
    uint256 public proposalCount;
    uint256 public constant VOTING_DURATION = 3 days;

    constructor(address _token) {
        governanceToken = IERC20(_token);
    }

    function createProposal(string calldata _description) external {
        require(governanceToken.balanceOf(msg.sender) > 0, "Must hold tokens to propose");
        
        proposalCount++;
        proposals[proposalCount] = Proposal({
            id: proposalCount,
            proposer: msg.sender,
            description: _description,
            votesFor: 0,
            votesAgainst: 0,
            endTime: block.timestamp + VOTING_DURATION,
            executed: false
        });
    }

    function vote(uint256 _proposalId, bool _support) external {
        Proposal storage p = proposals[_proposalId];
        require(block.timestamp < p.endTime, "Voting ended");
        require(!hasVoted[_proposalId][msg.sender], "Already voted");

        uint256 weight = governanceToken.balanceOf(msg.sender);
        require(weight > 0, "No voting power");

        if (_support) {
            p.votesFor += weight;
        } else {
            p.votesAgainst += weight;
        }

        hasVoted[_proposalId][msg.sender] = true;
    }

    function execute(uint256 _proposalId) external {
        Proposal storage p = proposals[_proposalId];
        require(block.timestamp >= p.endTime, "Voting still active");
        require(p.votesFor > p.votesAgainst, "Proposal failed");
        require(!p.executed, "Already executed");

        p.executed = true;
        // Logic for execution (e.g., sending funds) would go here
    }
}
