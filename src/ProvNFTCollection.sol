// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import { ERC721SeaDrop } from "./ERC721SeaDrop.sol";

/// @custom:security-contact contact@prov.ai
contract ProvNFTCollection is ERC721SeaDrop {
    address[] private s_collectionOwner;
    uint256[] private s_collectionNFTs;

    event PayFee(address indexed sender);

    constructor(
        string memory _name,
        string memory _symbol,
        address[] memory _allowedSeaDrop
    ) ERC721SeaDrop(_name, _symbol, _allowedSeaDrop) {
        s_collectionOwner = _allowedSeaDrop;
    }

    function imageGenerationPayment(uint256 _cost, address _owner)
        public
        payable
    {
        // TODO: test only owner can generate images from their collection
        _onlyAllowedSeaDrop(msg.sender);

        require(
            msg.value >= _cost,
            "Insufficient payment amount for AI image generation"
        );
        // TODO: transfer funds to factory contract
        emit PayFee(_owner);
    }

    // TODO: Test correct mint tokenIds are stored in s_collectionNFTs
    function _afterTokenTransfers(
        address from,
        address to,
        uint256 startTokenId,
        uint256 quantity
    ) internal override {
        super._afterTokenTransfers(from, to, startTokenId, quantity);

        // Append minted token IDs to the s_collectionNFTs array
        for (uint256 i = 0; i < quantity; i++) {
            uint256 tokenId = startTokenId + i;
            s_collectionNFTs.push(tokenId);
        }
    }

    // Getter functions for private variables
    function getCollectionOwner() public view returns (address[] memory) {
        return s_collectionOwner;
    }

    function getCollectionNFTs() public view returns (uint256[] memory) {
        return s_collectionNFTs;
    }
}
