// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

interface IProvNFTFactory {
    function createNFTCollection(string memory _name, string memory _symbol)
        external
        returns (address);

    function getOwnerCollection(
        address collectionOwner,
        uint256 _collectionIndex
    ) external view returns (address);

    function getOwnerCollections(address owner)
        external
        view
        returns (address[] memory);
}
