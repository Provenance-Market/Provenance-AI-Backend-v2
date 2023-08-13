// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import { ERC721SeaDrop } from "./ERC721SeaDrop.sol";

/// @custom:security-contact contact@prov.ai
contract ProvNFTCollection is ERC721SeaDrop {
    address[] private s_collectionOwner;
    mapping(address => address[]) private s_collectionNFTs;

    event PayFee(address indexed sender);

    constructor(
        string memory _name,
        string memory _symbol,
        address[] memory _allowedSeaDrop
    ) ERC721SeaDrop(_name, _symbol, _allowedSeaDrop) {
        s_collectionOwner = _allowedSeaDrop;
    }

    function mintSeaDrop(address _minter, uint256 _quantity) public override {
        // TODO: add nft addy to s_collectionNFTs
        super.mintSeaDrop(_minter, _quantity);
    }

    function imageGenerationPayment(uint256 _cost, address _owner)
        public
        payable
    {
        require(
            msg.value >= _cost,
            "Insufficient payment amount for AI image generation"
        );
        emit PayFee(_owner);
    }

    // Getter functions for private variables
    function getCollectionOwner() public view returns (address[] memory) {
        return s_collectionOwner;
    }
}
