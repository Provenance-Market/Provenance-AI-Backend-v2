// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import { Script, console } from "forge-std/Script.sol";
import { ISeaDrop } from "../src/interfaces/ISeaDrop.sol";
import { ProvNFTFactory } from "../src/ProvNFTFactory.sol";
import { ProvNFTCollection } from "../src/ProvNFTCollection.sol";

contract InteractWithProvNFTFactory is Script {
    // ISeaDrop public seadrop;
    ProvNFTFactory public factory;
    ProvNFTCollection public collection;

    // Set the address of the deployed ISeaDrop contract
    address creator = 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266; // 1st anvil account posing as the nft collection creator
    address feeRecipient = 0x70997970C51812dc3A010C7d01b50e0d17dc79C8; // 2nd anvil account account posing as the OpenSea addy
    address provFeeRecipient = 0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC; // 3rd anvil account posing as the prov multiSig
    address seadrop = 0x5FbDB2315678afecb367f032d93F642f64180aa3; // SeaDrop deployed on Anvil


    // Collection config
    uint256 maxSupply = 100;

    // Drop config
    uint16 feeBps = 1000; // 10%
    uint16 provFeeBps = 100; // 1%
    uint80 mintPrice = 0.0001 ether;
    uint16 maxTotalMintableByWallet = 5;


    function run() external {
        vm.startBroadcast();

        // Set the address of the deployed ProvNFTFactory contract
        // factory = ProvNFTFactory(0x0DCd1Bf9A1b36cE34237eEaFef220932846BCD82);

        // Call the createNFTCollection function on the deployed contract
        // collection = factory.createNFTCollection(
        //     "Collection 1",
        //     "C1"
        // );
        // console.log("NFT Collection created at address:", collection);

        // Interact with the newly created collection
        // collection = ProvNFTCollection(collectionAddress);
        // collection.setMaxSupply(100);

        // Call the mintPublic function on the ISeaDrop contract
        bool success = try ISeaDrop(seadrop).mintPublic(
            address(collection),
            feeRecipient,
            address(0),
            3, // quantity
            provFeeBps,
            provFeeRecipient
        );

        if (success) {
            console.log("NFTs minted successfully");
        } else {
            console.log("Failed to mint NFTs");
        }
    }
}
