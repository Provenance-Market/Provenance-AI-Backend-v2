# ERC721SeaDropCloneFactory
[Git Source](https://github.com/Provenance-Market/Provenance-AI-Backend-v2/blob/fbadee5cddd353412cd3f65d2fe397629bb40751/src/clones/ERC721SeaDropCloneFactory.sol)


## State Variables
### seaDropCloneableUpgradeableImplementation

```solidity
address public immutable seaDropCloneableUpgradeableImplementation;
```


### DEFAULT_SEADROP

```solidity
address public constant DEFAULT_SEADROP = 0x00005EA00Ac477B1030CE78506496e8C2dE24bf5;
```


## Functions
### constructor


```solidity
constructor();
```

### createClone


```solidity
function createClone(string memory name, string memory symbol, bytes32 salt) external returns (address);
```

