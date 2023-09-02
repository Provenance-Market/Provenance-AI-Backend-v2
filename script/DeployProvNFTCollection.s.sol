// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import "forge-std/Script.sol";

// import { ERC721SeaDrop } from "../src/ERC721SeaDrop.sol";
import { ProvNFTCollection } from "../src/ProvNFTCollection.sol";

import { ISeaDrop } from "../src/interfaces/ISeaDrop.sol";

import { PublicDrop } from "../src/lib/SeaDropStructs.sol";

contract DeployProvNFTCollection is Script {
    // Addresses
    address seadrop = 0x00005EA00Ac477B1030CE78506496e8C2dE24bf5;
    address creator = 0x41196385fB1ec44F30c2E64D789dBa2ba004Bb24;
    address feeRecipient = 0xC61E892F43ea5fbecb654c7e166A4fF96576969E;
    address provFeeRecipient = 0xC61E892F43ea5fbecb654c7e166A4fF96576969E;

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
            "Prov SeaDrop Collection 1",
            "PSDC1",
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

        // We are ready, let's mint the first collection!
        ISeaDrop(seadrop).mintPublic{ value: mintPrice * 1 }(
            address(collection),
            feeRecipient,
            address(0),
            1, // quantity
            provFeeBps,
            provFeeRecipient
        );
    }
}
