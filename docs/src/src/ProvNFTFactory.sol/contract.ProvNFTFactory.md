# ProvNFTFactory
[Git Source](https://github.com/Provenance-Market/Provenance-AI-Backend-v2/blob/fbadee5cddd353412cd3f65d2fe397629bb40751/src/ProvNFTFactory.sol)


## State Variables
### ownerCollections

```solidity
mapping(address => ProvNFTCollection[]) private ownerCollections;
```


## Functions
### createNFTCollection


```solidity
function createNFTCollection(string memory _name, string memory _symbol) public returns (address);
```

### getOwnerCollection


```solidity
function getOwnerCollection(address collectionOwner, uint256 _collectionIndex)
    external
    view
    returns (ProvNFTCollection);
```

### getOwnerCollections


```solidity
function getOwnerCollections(address owner) external view returns (ProvNFTCollection[] memory);
```

## Events
### ProvNFTCreated

```solidity
event ProvNFTCreated(address owner, address deployedContract);
```

