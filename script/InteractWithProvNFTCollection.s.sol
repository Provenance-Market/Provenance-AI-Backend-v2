// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import { Script, console } from "forge-std/Script.sol";
import { ISeaDrop } from "../src/interfaces/ISeaDrop.sol";

contract InteractWithProvNFTCollection is Script {
    // Set the address of the deployed ISeaDrop contract
    address creator = 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266; // 1st anvil account posing as the nft collection creator
    address feeRecipient = 0x70997970C51812dc3A010C7d01b50e0d17dc79C8; // 2nd anvil account account posing as the OpenSea addy
    address provFeeRecipient = 0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC; // 3rd anvil account posing as the prov multiSig
    address seadrop = 0x5FbDB2315678afecb367f032d93F642f64180aa3; // SeaDrop deployed on Anvil
    address collection = 0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512; // anvil deployed collection contract

    // Collection config
    uint256 maxSupply = 100;
    uint16 provFeeBps = 100; // 1%
    uint80 mintPrice = 0.0001 ether;

    function run() external {
        vm.startBroadcast();

        ISeaDrop(seadrop).mintPublic{ value: mintPrice * 3 }(
            collection,
            feeRecipient,
            address(0),
            3, // quantity
            provFeeBps,
            provFeeRecipient
        );
    }
}
