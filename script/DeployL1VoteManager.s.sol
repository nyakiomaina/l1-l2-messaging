// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/L1VoteManager.sol";
import "forge-std/Script.sol";

contract DeployL1Voting is Script {
    function run() external {
        uint256 privateKey = vm.envUint("PRIVATE_KEY");

        vm.startBroadcast(privateKey);

        address messengerAddress = 0x5086d1eEF304eb5284A0f6720f79403b4e9bE294;
        address l2VotingAddress = vm.envAddress("L2_VOTING_ADDRESS");

        L1Voting l1Voting = new L1Voting(messengerAddress, l2VotingAddress);

        console.log("L1Voting deployed at:", address(l1Voting));

        vm.stopBroadcast();
    }
}
