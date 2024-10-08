// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {TestToken} from "../src/TestToken.sol";
import "forge-std/console.sol";

contract DeployTestToken is Script {
    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);
        // Specify the initial supply of tokens
        uint256 initialSupply = 10_000 * 10**18;

        // Deploy the contract
        TestToken token = new TestToken(initialSupply);

        // Print the address of the deployed contract
        console.log("TestToken deployed to:", address(token));

        // Stop broadcasting transactions
        vm.stopBroadcast();
    }
}
