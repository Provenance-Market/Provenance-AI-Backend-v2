// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import { Script, console } from "forge-std/Script.sol";
import { ProvNFTFactory } from "../src/ProvNFTFactory.sol";

contract DeployProvNFTFactory is Script {
    address creator1 = 0x90F79bf6EB2c4f870365E785982E1f101E93b906; // 4th anvil account posing as an nft collection creator
    address creator2 = 0x15d34AAf54267DB7D7c367839AAf71A00a2C6A65; // 5th anvil account account posing as another collection creator

    function run() external {
        vm.startBroadcast();

        ProvNFTFactory factory = new ProvNFTFactory();

        // Create a couple of NFT collections for testing
        // address collection1 = factory.createNFTCollection("Collection 1", "C1");
        // address collection2 = factory.createNFTCollection("Collection 2", "C2");

        // Print the addresses of the new collections
        // console.log("Collection 1 created at address:", collection1);
        // console.log("Collection 2 created at address:", collection2);
    }
}
