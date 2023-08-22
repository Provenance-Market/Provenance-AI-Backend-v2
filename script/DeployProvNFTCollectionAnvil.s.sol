// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import "forge-std/Script.sol";

// import { ERC721SeaDrop } from "../src/ERC721SeaDrop.sol";
import { ProvNFTCollection } from "../src/ProvNFTCollection.sol";

import { ISeaDrop } from "../src/interfaces/ISeaDrop.sol";

import { PublicDrop } from "../src/lib/SeaDropStructs.sol";

contract DeployProvNFTCollection is Script {
    // Addresses
    address seadrop = 0x5FbDB2315678afecb367f032d93F642f64180aa3; // SeaDrop deployed on Anvil
    address creator = 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266; // 1st anvil account
    address feeRecipient = 0x70997970C51812dc3A010C7d01b50e0d17dc79C8; // 2nd account
    address provFeeRecipient = 0xC61E892F43ea5fbecb654c7e166A4fF96576969E;

    // Token config
    uint256 maxSupply = 100;

    // Drop config
    uint16 feeBps = 500; // 5%
    uint16 provFeeBps = 100; // 1%
    uint80 mintPrice = 0.0001 ether;
    uint16 maxTotalMintableByWallet = 5;

    function run() external {
        vm.startBroadcast();

        address[] memory allowedSeadrop = new address[](1);
        allowedSeadrop[0] = seadrop;

        // This example uses ERC721SeaDrop. For separate Owner and
        // Administrator privileges, use ERC721PartnerSeaDrop.
        ProvNFTCollection token = new ProvNFTCollection(
            "Prov SeaDrop Token 2",
            "PSDT2",
            allowedSeadrop
        );

        // Configure the token.
        token.setMaxSupply(maxSupply);

        // Configure the drop parameters.
        token.updateCreatorPayoutAddress(seadrop, creator);
        token.updateAllowedFeeRecipient(seadrop, feeRecipient, true);
        token.updatePublicDrop(
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

        // We are ready, let's mint the first 3 tokens!
        ISeaDrop(seadrop).mintPublic{ value: mintPrice * 1 }(
            address(token),
            feeRecipient,
            address(0),
            1, // quantity
            provFeeBps,
            provFeeRecipient
        );
    }
}
