# ERC721PartnerSeaDropBurnable
[Git Source](https://github.com/Provenance-Market/Provenance-AI-Backend-v2/blob/fbadee5cddd353412cd3f65d2fe397629bb40751/src/extensions/ERC721PartnerSeaDropBurnable.sol)

**Inherits:**
[ERC721PartnerSeaDrop](/src/ERC721PartnerSeaDrop.sol/contract.ERC721PartnerSeaDrop.md)

**Authors:**
James Wenzel (emo.eth), Ryan Ghods (ralxz.eth), Stephan Min (stephanm.eth)

ERC721PartnerSeaDropBurnable is a token contract that extends
ERC721PartnerSeaDrop to additionally provide a burn function.


## Functions
### constructor

Deploy the token contract with its name, symbol,
administrator, and allowed SeaDrop addresses.


```solidity
constructor(string memory name, string memory symbol, address administrator, address[] memory allowedSeaDrop)
    ERC721PartnerSeaDrop(name, symbol, administrator, allowedSeaDrop);
```

### burn

Burns `tokenId`. The caller must own `tokenId` or be an
approved operator.


```solidity
function burn(uint256 tokenId) external;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`tokenId`|`uint256`|The token id to burn.|


