# ERC721SeaDropBurnable
[Git Source](https://github.com/Provenance-Market/Provenance-AI-Backend-v2/blob/fbadee5cddd353412cd3f65d2fe397629bb40751/src/extensions/ERC721SeaDropBurnable.sol)

**Inherits:**
[ERC721SeaDrop](/src/ERC721SeaDrop.sol/contract.ERC721SeaDrop.md)

**Authors:**
James Wenzel (emo.eth), Ryan Ghods (ralxz.eth), Stephan Min (stephanm.eth), Michael Cohen (notmichael.eth)

ERC721SeaDropBurnable is a token contract that extends
ERC721SeaDrop to additionally provide a burn function.


## Functions
### constructor

Deploy the token contract with its name, symbol,
and allowed SeaDrop addresses.


```solidity
constructor(string memory name, string memory symbol, address[] memory allowedSeaDrop)
    ERC721SeaDrop(name, symbol, allowedSeaDrop);
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


