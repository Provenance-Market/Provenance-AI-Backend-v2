# MaliciousRecipient
[Git Source](https://github.com/Provenance-Market/Provenance-AI-Backend-v2/blob/fbadee5cddd353412cd3f65d2fe397629bb40751/src/test/MaliciousRecipient.sol)


## State Variables
### startAttack

```solidity
bool public startAttack;
```


### token

```solidity
address public token;
```


### seaDrop

```solidity
SeaDrop public seaDrop;
```


## Functions
### receive


```solidity
receive() external payable;
```

### setStartAttack


```solidity
function setStartAttack() public payable;
```

### attack


```solidity
function attack(SeaDrop _seaDrop, address _token) external payable;
```

