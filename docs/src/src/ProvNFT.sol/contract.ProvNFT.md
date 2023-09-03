# ProvNFT
[Git Source](https://github.com/Provenance-Market/Provenance-AI-Backend-v2/blob/fbadee5cddd353412cd3f65d2fe397629bb40751/src/ProvNFT.sol)

**Inherits:**
ERC1155URIStorage, ERC1155Supply, Pausable, PaymentSplitter


## State Variables
### _tokenIds

```solidity
Counters.Counter private _tokenIds;
```


### SUPPLY_PER_ID

```solidity
uint8 constant SUPPLY_PER_ID = 1;
```


### s_name

```solidity
string private s_name;
```


### s_symbol

```solidity
string private s_symbol;
```


### s_mintPrice

```solidity
uint256 private s_mintPrice;
```


### s_owners

```solidity
address[] private s_owners;
```


### _ownedTokens

```solidity
mapping(address => uint256[]) private _ownedTokens;
```


## Functions
### constructor


```solidity
constructor(
    string memory _name,
    string memory _symbol,
    address[] memory _payees,
    uint256[] memory _shares,
    uint256 _mintFee
) ERC1155("") PaymentSplitter(_payees, _shares);
```

### onlyOwners


```solidity
modifier onlyOwners();
```

### mint


```solidity
function mint(string memory _metadataURI, address _owner) public payable returns (uint256);
```

### imageGenerationPayment


```solidity
function imageGenerationPayment(uint256 _cost, address _owner) public payable whenNotPaused;
```

### mintBatch


```solidity
function mintBatch(uint256 mintAmount, string[] memory metadataURIs) public payable returns (uint256[] memory);
```

### getTotalSupply


```solidity
function getTotalSupply() public view returns (uint256);
```

### setMintFee


```solidity
function setMintFee(uint256 _newMintFee) public onlyOwners;
```

### pause


```solidity
function pause() public onlyOwners;
```

### unpause


```solidity
function unpause() public onlyOwners;
```

### _beforeTokenTransfer


```solidity
function _beforeTokenTransfer(
    address operator,
    address from,
    address to,
    uint256[] memory ids,
    uint256[] memory amounts,
    bytes memory data
) internal override(ERC1155, ERC1155Supply) whenNotPaused;
```

### uri


```solidity
function uri(uint256 tokenId) public view virtual override(ERC1155URIStorage, ERC1155) returns (string memory);
```

### _addTokenToOwner


```solidity
function _addTokenToOwner(address to, uint256 tokenId) private;
```

### tokensOfOwner


```solidity
function tokensOfOwner(address owner) public view returns (uint256[] memory);
```

### tokenURIsOfOwner


```solidity
function tokenURIsOfOwner(address owner) public view returns (string[] memory);
```

### getName


```solidity
function getName() public view returns (string memory);
```

### getSymbol


```solidity
function getSymbol() public view returns (string memory);
```

### getMintPrice


```solidity
function getMintPrice() public view returns (uint256);
```

### getOwners


```solidity
function getOwners() public view returns (address[] memory);
```

## Events
### NFTMinted

```solidity
event NFTMinted(address indexed owner, uint256 indexed tokenId, uint256 value);
```

### PayFee

```solidity
event PayFee(address indexed sender);
```

## Errors
### ProvNFT__OnlyOwner

```solidity
error ProvNFT__OnlyOwner();
```

### ProvNFT__NotEnoughFundsMinting

```solidity
error ProvNFT__NotEnoughFundsMinting();
```

### ProvNFT__NotEnoughFundsImgGen

```solidity
error ProvNFT__NotEnoughFundsImgGen();
```

