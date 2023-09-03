# ProvNFTCollection
[Git Source](https://github.com/Provenance-Market/Provenance-AI-Backend-v2/blob/fbadee5cddd353412cd3f65d2fe397629bb40751/src/ProvNFTCollection.sol)

**Inherits:**
[ERC721SeaDrop](/src/ERC721SeaDrop.sol/contract.ERC721SeaDrop.md)


## State Variables
### s_collectionOwner

```solidity
address public s_collectionOwner;
```


### s_collectionNFTs

```solidity
uint256[] public s_collectionNFTs;
```


## Functions
### constructor


```solidity
constructor(string memory _name, string memory _symbol, address[] memory _allowedSeaDrop)
    ERC721SeaDrop(_name, _symbol, _allowedSeaDrop);
```

### imageGenerationPayment


```solidity
function imageGenerationPayment(uint256 _cost, address _owner, address _multiSig) external payable;
```

### _afterTokenTransfers


```solidity
function _afterTokenTransfers(address from, address to, uint256 startTokenId, uint256 quantity) internal override;
```

## Events
### PayFee

```solidity
event PayFee(address indexed sender);
```

