// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import { ProvNFTCollection } from "./ProvNFTCollection.sol";

contract ProvNFTFactory {
    mapping(address => ProvNFTCollection[]) private ownerCollections;

    event ProvNFTCreated(address owner, address deployedContract);

    function createBasicNft(string memory _name, string memory _symbol)
        public
        returns (address)
    {
        address collectionOwner = msg.sender;
        address[] memory ownersArray = new address[](1);
        ownersArray[0] = collectionOwner;

        ProvNFTCollection newBasicNft = new ProvNFTCollection(
            _name,
            _symbol,
            ownersArray
        );

        ownerCollections[collectionOwner].push(newBasicNft);

        emit ProvNFTCreated(collectionOwner, address(newBasicNft));
        return address(newBasicNft);
    }

    // Getter functions
    function getOwnerCollection(
        address collectionOwner,
        uint256 _collectionIndex
    ) external view returns (ProvNFTCollection) {
        ProvNFTCollection ownerCollection = ownerCollections[collectionOwner][
            _collectionIndex
        ];
        require(
            address(ownerCollection) != address(0),
            "Invalid collection index"
        );
        return ownerCollection;
    }

    function getOwnerCollections(address owner)
        external
        view
        returns (ProvNFTCollection[] memory)
    {
        return ownerCollections[owner];
    }
}
