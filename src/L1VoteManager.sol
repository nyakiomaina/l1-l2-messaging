// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Interface for L1CrossDomainMessenger
interface IL1CrossDomainMessenger {
    function sendMessage(
        address _target,
        bytes calldata _message,
        uint32 _minGasLimit
    ) external;
}

contract L1Voting {
    address public messengerAddress;
    address public l2VotingAddress;

    // Event emitted when a vote is cast
    event VoteCast(address voter, uint256 candidateId);

    constructor(address _messengerAddress, address _l2VotingAddress) {
        messengerAddress = _messengerAddress;
        l2VotingAddress = _l2VotingAddress;
    }

    // Function to vote for a candidate
    function vote(uint256 _candidateId) external {
        // Emit an event on L1
        emit VoteCast(msg.sender, _candidateId);

        // Encode the function call to L2
        bytes memory message = abi.encodeWithSignature(
            "recordVote(uint256)",
            _candidateId
        );

        // Get the messenger contract
        IL1CrossDomainMessenger messenger = IL1CrossDomainMessenger(
            messengerAddress
        );

        // Send the message to L2
        messenger.sendMessage(
            l2VotingAddress,
            message,
            1000000 // Adjust gas limit as needed
        );
    }
}
