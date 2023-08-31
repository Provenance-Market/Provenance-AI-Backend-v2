// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import { ProvNFTCollection } from "./ProvNFTCollection.sol";
import {
    PaymentSplitter
} from "openzeppelin-contracts/finance/PaymentSplitter.sol";

contract ProvNFTFactory is PaymentSplitter {
    mapping(address => ProvNFTCollection[]) private ownerCollections;
    address[] private s_payees;

    event ProvNFTCreated(address owner, address deployedContract);

    constructor(address[] memory _payees, uint256[] memory _shares)
        PaymentSplitter(_payees, _shares)
    {
        s_payees = _payees;
    }

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
