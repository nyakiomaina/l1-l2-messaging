// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/L2VoteRecorder.sol";
import "forge-std/Script.sol";

contract DeployL2Voting is Script {
    function run() external {
        uint256 privateKey = vm.envUint("PRIVATE_KEY");

        vm.startBroadcast(privateKey);

        address crossDomainMessenger = 0x4200000000000000000000000000000000000007;

        L2Voting l2Voting = new L2Voting(crossDomainMessenger);

        console.log("L2Voting deployed at:", address(l2Voting));

        vm.stopBroadcast();
    }
}
