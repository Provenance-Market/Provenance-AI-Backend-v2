// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import { ProvNFT } from "./ProvNFT.sol";

contract ProvNFTFactory {
    ProvNFT[] public deployedContracts;
    mapping(address => ProvNFT[]) private ownerCollections;

    function createBasicNft(
        string memory name,
        string memory symbol,
        address[] memory payees,
        uint256[] memory shares,
        uint256 mintFee
    ) public returns (ProvNFT) {
        address collectionOwner = msg.sender;
        ProvNFT newBasicNft = new ProvNFT(
            name,
            symbol,
            payees,
            shares,
            mintFee,
            collectionOwner
        );
        ownerCollections[collectionOwner].push(newBasicNft);
        deployedContracts.push(newBasicNft);
        emit ProvNFTCreated(collectionOwner, address(newBasicNft));
        return address(newBasicNft);
    }

    // Helper functions
    function getOwnerCollection(uint256 _collectionIndex)
        private
        view
        returns (ProvNFT)
    {
        ProvNFT ownerCollection = ownerCollections[msg.sender][
            _collectionIndex
        ];
        require(
            address(ownerCollection) != address(0),
            "Invalid collection index"
        );
        return ownerCollection;
    }

    // Getter functions
    function getOwnerCollections(address owner)
        public
        view
        returns (ProvNFT[] memory)
    {
        return ownerCollections[owner];
    }

    function getDeployedContracts() public view returns (ProvNFT[] memory) {
        return deployedContracts;
    }
}
