// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Interface for L2CrossDomainMessenger
interface IL2CrossDomainMessenger {
    function xDomainMessageSender() external view returns (address);
}

contract L2Voting {
    // Address of the L2CrossDomainMessenger
    address public crossDomainMessenger;

    // Mapping to store vote counts
    mapping(uint256 => uint256) public votes;

    // Event emitted when a vote is received
    event VoteReceived(address voter, uint256 candidateId, uint256 totalVotes);

    constructor(address _crossDomainMessenger) {
        crossDomainMessenger = _crossDomainMessenger;
    }

    // Function to record a vote from L1
    function recordVote(uint256 _candidateId) external {
        // Ensure the call came from the CrossDomainMessenger
        require(
            msg.sender == crossDomainMessenger,
            "Caller is not the cross-domain messenger"
        );

        // Get the L1 sender address
        address l1Sender = IL2CrossDomainMessenger(crossDomainMessenger)
            .xDomainMessageSender();

        // Increment the vote count for the candidate
        votes[_candidateId] += 1;

        // Emit an event for the vote
        emit VoteReceived(l1Sender, _candidateId, votes[_candidateId]);
    }
}
