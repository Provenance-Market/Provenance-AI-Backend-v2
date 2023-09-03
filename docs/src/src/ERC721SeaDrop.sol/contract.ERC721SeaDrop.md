# ERC721SeaDrop
[Git Source](https://github.com/Provenance-Market/Provenance-AI-Backend-v2/blob/fbadee5cddd353412cd3f65d2fe397629bb40751/src/ERC721SeaDrop.sol)

**Inherits:**
[ERC721ContractMetadata](/src/ERC721ContractMetadata.sol/contract.ERC721ContractMetadata.md), [INonFungibleSeaDropToken](/src/interfaces/INonFungibleSeaDropToken.sol/interface.INonFungibleSeaDropToken.md), [ERC721SeaDropStructsErrorsAndEvents](/src/lib/ERC721SeaDropStructsErrorsAndEvents.sol/interface.ERC721SeaDropStructsErrorsAndEvents.md), ReentrancyGuard, DefaultOperatorFilterer

**Authors:**
James Wenzel (emo.eth), Ryan Ghods (ralxz.eth), Stephan Min (stephanm.eth), Michael Cohen (notmichael.eth)

ERC721SeaDrop is a token contract that contains methods
to properly interact with SeaDrop.


## State Variables
### _allowedSeaDrop
Track the allowed SeaDrop addresses.


```solidity
mapping(address => bool) internal _allowedSeaDrop;
```


### _enumeratedAllowedSeaDrop
Track the enumerated allowed SeaDrop addresses.


```solidity
address[] internal _enumeratedAllowedSeaDrop;
```


## Functions
### _onlyAllowedSeaDrop

*Reverts if not an allowed SeaDrop contract.
This function is inlined instead of being a modifier
to save contract space from being inlined N times.*


```solidity
function _onlyAllowedSeaDrop(address seaDrop) internal view;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`seaDrop`|`address`|The SeaDrop address to check if allowed.|


### constructor

Deploy the token contract with its name, symbol,
and allowed SeaDrop addresses.


```solidity
constructor(string memory name, string memory symbol, address[] memory allowedSeaDrop)
    ERC721ContractMetadata(name, symbol);
```

### updateAllowedSeaDrop

Update the allowed SeaDrop contracts.
Only the owner or administrator can use this function.


```solidity
function updateAllowedSeaDrop(address[] calldata allowedSeaDrop) external virtual override onlyOwner;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`allowedSeaDrop`|`address[]`|The allowed SeaDrop addresses.|


### _updateAllowedSeaDrop

Internal function to update the allowed SeaDrop contracts.


```solidity
function _updateAllowedSeaDrop(address[] calldata allowedSeaDrop) internal;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`allowedSeaDrop`|`address[]`|The allowed SeaDrop addresses.|


### _startTokenId

*Overrides the `_startTokenId` function from ERC721A
to start at token id `1`.
This is to avoid future possible problems since `0` is usually
used to signal values that have not been set or have been removed.*


```solidity
function _startTokenId() internal view virtual override returns (uint256);
```

### tokenURI

*Overrides the `tokenURI()` function from ERC721A
to return just the base URI if it is implied to not be a directory.
This is to help with ERC721 contracts in which the same token URI
is desired for each token, such as when the tokenURI is 'unrevealed'.*


```solidity
function tokenURI(uint256 tokenId) public view virtual override returns (string memory);
```

### mintSeaDrop

Mint tokens, restricted to the SeaDrop contract.

*NOTE: If a token registers itself with multiple SeaDrop
contracts, the implementation of this function should guard
against reentrancy. If the implementing token uses
_safeMint(), or a feeRecipient with a malicious receive() hook
is specified, the token or fee recipients may be able to execute
another mint in the same transaction via a separate SeaDrop
contract.
This is dangerous if an implementing token does not correctly
update the minterNumMinted and currentTotalSupply values before
transferring minted tokens, as SeaDrop references these values
to enforce token limits on a per-wallet and per-stage basis.
ERC721A tracks these values automatically, but this note and
nonReentrant modifier are left here to encourage best-practices
when referencing this contract.*


```solidity
function mintSeaDrop(address minter, uint256 quantity) external virtual override nonReentrant;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`minter`|`address`|  The address to mint to.|
|`quantity`|`uint256`|The number of tokens to mint.|


### updatePublicDrop

Update the public drop data for this nft contract on SeaDrop.
Only the owner can use this function.


```solidity
function updatePublicDrop(address seaDropImpl, PublicDrop calldata publicDrop) external virtual override;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`seaDropImpl`|`address`|The allowed SeaDrop contract.|
|`publicDrop`|`PublicDrop`| The public drop data.|


### updateAllowList

Update the allow list data for this nft contract on SeaDrop.
Only the owner can use this function.


```solidity
function updateAllowList(address seaDropImpl, AllowListData calldata allowListData) external virtual override;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`seaDropImpl`|`address`|  The allowed SeaDrop contract.|
|`allowListData`|`AllowListData`|The allow list data.|


### updateTokenGatedDrop

Update the token gated drop stage data for this nft contract
on SeaDrop.
Only the owner can use this function.
Note: If two INonFungibleSeaDropToken tokens are doing
simultaneous token gated drop promotions for each other,
they can be minted by the same actor until
`maxTokenSupplyForStage` is reached. Please ensure the
`allowedNftToken` is not running an active drop during the
`dropStage` time period.


```solidity
function updateTokenGatedDrop(address seaDropImpl, address allowedNftToken, TokenGatedDropStage calldata dropStage)
    external
    virtual
    override;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`seaDropImpl`|`address`|    The allowed SeaDrop contract.|
|`allowedNftToken`|`address`|The allowed nft token.|
|`dropStage`|`TokenGatedDropStage`|      The token gated drop stage data.|


### updateDropURI

Update the drop URI for this nft contract on SeaDrop.
Only the owner can use this function.


```solidity
function updateDropURI(address seaDropImpl, string calldata dropURI) external virtual override;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`seaDropImpl`|`address`|The allowed SeaDrop contract.|
|`dropURI`|`string`|    The new drop URI.|


### updateCreatorPayoutAddress

Update the creator payout address for this nft contract on
SeaDrop.
Only the owner can set the creator payout address.


```solidity
function updateCreatorPayoutAddress(address seaDropImpl, address payoutAddress) external;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`seaDropImpl`|`address`|  The allowed SeaDrop contract.|
|`payoutAddress`|`address`|The new payout address.|


### updateAllowedFeeRecipient

Update the allowed fee recipient for this nft contract
on SeaDrop.
Only the owner can set the allowed fee recipient.


```solidity
function updateAllowedFeeRecipient(address seaDropImpl, address feeRecipient, bool allowed) external virtual;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`seaDropImpl`|`address`| The allowed SeaDrop contract.|
|`feeRecipient`|`address`|The new fee recipient.|
|`allowed`|`bool`|     If the fee recipient is allowed.|


### updateSignedMintValidationParams

Update the server-side signers for this nft contract
on SeaDrop.
Only the owner can use this function.


```solidity
function updateSignedMintValidationParams(
    address seaDropImpl,
    address signer,
    SignedMintValidationParams memory signedMintValidationParams
) external virtual override;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`seaDropImpl`|`address`|               The allowed SeaDrop contract.|
|`signer`|`address`|                    The signer to update.|
|`signedMintValidationParams`|`SignedMintValidationParams`|Minimum and maximum parameters to enforce for signed mints.|


### updatePayer

Update the allowed payers for this nft contract on SeaDrop.
Only the owner can use this function.


```solidity
function updatePayer(address seaDropImpl, address payer, bool allowed) external virtual override;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`seaDropImpl`|`address`|The allowed SeaDrop contract.|
|`payer`|`address`|      The payer to update.|
|`allowed`|`bool`|    Whether the payer is allowed.|


### getMintStats

Returns a set of mint stats for the address.
This assists SeaDrop in enforcing maxSupply,
maxTotalMintableByWallet, and maxTokenSupplyForStage checks.

*NOTE: Implementing contracts should always update these numbers
before transferring any tokens with _safeMint() to mitigate
consequences of malicious onERC721Received() hooks.*


```solidity
function getMintStats(address minter)
    external
    view
    override
    returns (uint256 minterNumMinted, uint256 currentTotalSupply, uint256 maxSupply);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`minter`|`address`|The minter address.|


### supportsInterface

Returns whether the interface is supported.


```solidity
function supportsInterface(bytes4 interfaceId)
    public
    view
    virtual
    override(IERC165, ERC721ContractMetadata)
    returns (bool);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`interfaceId`|`bytes4`|The interface id to check against.|


### setApprovalForAll

*Approve or remove `operator` as an operator for the caller.
Operators can call {transferFrom} or {safeTransferFrom}
for any token owned by the caller.
Requirements:
- The `operator` cannot be the caller.
- The `operator` must be allowed.
Emits an {ApprovalForAll} event.*


```solidity
function setApprovalForAll(address operator, bool approved) public override onlyAllowedOperatorApproval(operator);
```

### approve

*Gives permission to `to` to transfer `tokenId` token to another account.
The approval is cleared when the token is transferred.
Only a single account can be approved at a time, so approving the
zero address clears previous approvals.
Requirements:
- The caller must own the token or be an approved operator.
- `tokenId` must exist.
- The `operator` mut be allowed.
Emits an {Approval} event.*


```solidity
function approve(address operator, uint256 tokenId) public override onlyAllowedOperatorApproval(operator);
```

### transferFrom

*Transfers `tokenId` from `from` to `to`.
Requirements:
- `from` cannot be the zero address.
- `to` cannot be the zero address.
- `tokenId` token must be owned by `from`.
- If the caller is not `from`, it must be approved to move this token
by either {approve} or {setApprovalForAll}.
- The operator must be allowed.
Emits a {Transfer} event.*


```solidity
function transferFrom(address from, address to, uint256 tokenId) public override onlyAllowedOperator(from);
```

### safeTransferFrom

*Equivalent to `safeTransferFrom(from, to, tokenId, '')`.*


```solidity
function safeTransferFrom(address from, address to, uint256 tokenId) public override onlyAllowedOperator(from);
```

### safeTransferFrom

*Safely transfers `tokenId` token from `from` to `to`.
Requirements:
- `from` cannot be the zero address.
- `to` cannot be the zero address.
- `tokenId` token must exist and be owned by `from`.
- If the caller is not `from`, it must be approved to move this token
by either {approve} or {setApprovalForAll}.
- If `to` refers to a smart contract, it must implement
{IERC721Receiver-onERC721Received}, which is called upon a safe transfer.
- The operator must be allowed.
Emits a {Transfer} event.*


```solidity
function safeTransferFrom(address from, address to, uint256 tokenId, bytes memory data)
    public
    override
    onlyAllowedOperator(from);
```

