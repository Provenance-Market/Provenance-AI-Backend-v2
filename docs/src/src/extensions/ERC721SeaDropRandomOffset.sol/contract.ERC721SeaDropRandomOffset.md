# ERC721SeaDropRandomOffset
[Git Source](https://github.com/Provenance-Market/Provenance-AI-Backend-v2/blob/fbadee5cddd353412cd3f65d2fe397629bb40751/src/extensions/ERC721SeaDropRandomOffset.sol)

**Inherits:**
[ERC721SeaDrop](/src/ERC721SeaDrop.sol/contract.ERC721SeaDrop.md)

**Authors:**
James Wenzel (emo.eth), Ryan Ghods (ralxz.eth), Stephan Min (stephanm.eth), Michael Cohen (notmichael.eth)

ERC721SeaDropRandomOffset is a token contract that extends
ERC721SeaDrop to apply a randomOffset to the tokenURI,
to enable fair metadata reveals.


## State Variables
### randomOffset
The random offset, between 1 and the MAX_SUPPLY at the time of
being set.


```solidity
uint256 public randomOffset;
```


### revealed
If the collection has been revealed and the randomOffset has
been set. 1=False, 2=True.


```solidity
uint256 public revealed = _REVEALED_FALSE;
```


### _REVEALED_FALSE
*For gas efficiency, uint is used instead of bool for revealed.*


```solidity
uint256 private constant _REVEALED_FALSE = 1;
```


### _REVEALED_TRUE

```solidity
uint256 private constant _REVEALED_TRUE = 2;
```


## Functions
### constructor

Deploy the token contract with its name, symbol,
and allowed SeaDrop addresses.


```solidity
constructor(string memory name, string memory symbol, address[] memory allowedSeaDrop)
    ERC721SeaDrop(name, symbol, allowedSeaDrop);
```

### setRandomOffset

Set the random offset, for a fair metadata reveal. Only callable
by the owner one time when the total number of minted tokens
equals the max supply. Should be called immediately before
reveal.


```solidity
function setRandomOffset() external onlyOwner;
```

### tokenURI

The token URI, offset by randomOffset, to enable fair metadata
reveals.


```solidity
function tokenURI(uint256 tokenId) public view override returns (string memory);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`tokenId`|`uint256`|The token id|


## Errors
### AlreadyRevealed
Revert when setting the randomOffset if already set.


```solidity
error AlreadyRevealed();
```

### NotFullyMinted
Revert when setting the randomOffset if the collection is
not yet fully minted.


```solidity
error NotFullyMinted();
```

