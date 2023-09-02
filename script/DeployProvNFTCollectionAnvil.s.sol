// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import "forge-std/Script.sol";

import { ProvNFTCollection } from "../src/ProvNFTCollection.sol";

import { ISeaDrop } from "../src/interfaces/ISeaDrop.sol";

import { PublicDrop } from "../src/lib/SeaDropStructs.sol";

contract DeployProvNFTCollection is Script {
    // Addresses
    address seadrop = 0x5FbDB2315678afecb367f032d93F642f64180aa3; // SeaDrop deployed on Anvil
    address creator = 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266; // 1st anvil account posing as the nft collection creator
    address feeRecipient = 0x70997970C51812dc3A010C7d01b50e0d17dc79C8; // 2nd anvil account account posing as the OpenSea addy
    address provFeeRecipient = 0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC; // 3rd anvil account posing as the prov multiSig

    // Collection config
    uint256 maxSupply = 100;

    // Drop config
    uint16 feeBps = 1000; // 10%
    uint16 provFeeBps = 100; // 1%
    uint80 mintPrice = 0.0001 ether;
    uint16 maxTotalMintableByWallet = 5;

    function run() external {
        vm.startBroadcast();

        address[] memory allowedSeadrop = new address[](1);
        allowedSeadrop[0] = seadrop;

        ProvNFTCollection collection = new ProvNFTCollection(
            "Prov SeaDrop Collection",
            "PSDC",
            allowedSeadrop
        );

        // Configure the collection.
        collection.setMaxSupply(maxSupply);

        // Configure the drop parameters.
        collection.updateCreatorPayoutAddress(seadrop, creator);
        collection.updateAllowedFeeRecipient(seadrop, feeRecipient, true);
        collection.updatePublicDrop(
            seadrop,
            PublicDrop(
                mintPrice,
                uint48(block.timestamp), // start time
                uint48(block.timestamp) + 1000, // end time
                maxTotalMintableByWallet,
                feeBps,
                true
            )
        );

        // We are ready, let's mint the first 3 collections!
        ISeaDrop(seadrop).mintPublic{ value: mintPrice * 3 }(
            address(collection),
            feeRecipient,
            address(0),
            3, // quantity
            provFeeBps,
            provFeeRecipient
        );
    }
}
