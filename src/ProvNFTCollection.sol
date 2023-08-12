// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import { ERC721SeaDrop } from "./ERC721SeaDrop.sol";

/// @custom:security-contact contact@prov.ai
contract ProvNFTCollection is ERC721SeaDrop {
    address[] private s_collectionOwner;

    constructor(
        string memory _name,
        string memory _symbol,
        address[] memory _allowedSeaDrop
    ) ERC721SeaDrop(_name, _symbol, _allowedSeaDrop) {
        s_collectionOwner = _allowedSeaDrop;
    }

    // Getter functions for private variables
    function getCollectionOwner() public view returns (address[] memory) {
        return s_collectionOwner;
    }
}
