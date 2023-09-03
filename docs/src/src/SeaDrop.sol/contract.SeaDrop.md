# SeaDrop
[Git Source](https://github.com/Provenance-Market/Provenance-AI-Backend-v2/blob/fbadee5cddd353412cd3f65d2fe397629bb40751/src/SeaDrop.sol)

**Inherits:**
[ISeaDrop](/src/interfaces/ISeaDrop.sol/interface.ISeaDrop.md), ReentrancyGuard

**Authors:**
James Wenzel (emo.eth), Ryan Ghods (ralxz.eth), Stephan Min (stephanm.eth)

SeaDrop is a contract to help facilitate ERC721 token drops
with functionality for public, allow list, server-side signed,
and token-gated drops.


## State Variables
### _publicDrops
Track the public drops.


```solidity
mapping(address => PublicDrop) private _publicDrops;
```


### _creatorPayoutAddresses
Track the creator payout addresses.


```solidity
mapping(address => address) private _creatorPayoutAddresses;
```


### _allowListMerkleRoots
Track the allow list merkle roots.


```solidity
mapping(address => bytes32) private _allowListMerkleRoots;
```


### _allowedFeeRecipients
Track the allowed fee recipients.


```solidity
mapping(address => mapping(address => bool)) private _allowedFeeRecipients;
```


### _enumeratedFeeRecipients
Track the enumerated allowed fee recipients.


```solidity
mapping(address => address[]) private _enumeratedFeeRecipients;
```


### _signedMintValidationParams
Track the parameters for allowed signers for server-side drops.


```solidity
mapping(address => mapping(address => SignedMintValidationParams)) private _signedMintValidationParams;
```


### _enumeratedSigners
Track the signers for each server-side drop.


```solidity
mapping(address => address[]) private _enumeratedSigners;
```


### _usedDigests
Track the used signature digests.


```solidity
mapping(bytes32 => bool) private _usedDigests;
```


### _allowedPayers
Track the allowed payers.


```solidity
mapping(address => mapping(address => bool)) private _allowedPayers;
```


### _enumeratedPayers
Track the enumerated allowed payers.


```solidity
mapping(address => address[]) private _enumeratedPayers;
```


### _tokenGatedDrops
Track the token gated drop stages.


```solidity
mapping(address => mapping(address => TokenGatedDropStage)) private _tokenGatedDrops;
```


### _enumeratedTokenGatedTokens
Track the tokens for token gated drops.


```solidity
mapping(address => address[]) private _enumeratedTokenGatedTokens;
```


### _tokenGatedRedeemed
Track the redeemed token IDs for token gated drop stages.


```solidity
mapping(address => mapping(address => mapping(uint256 => bool))) private _tokenGatedRedeemed;
```


### _SIGNED_MINT_TYPEHASH
Internal constants for EIP-712: Typed structured
data hashing and signing


```solidity
bytes32 internal constant _SIGNED_MINT_TYPEHASH = keccak256(
    "SignedMint(" "address nftContract," "address minter," "address feeRecipient," "MintParams mintParams,"
    "uint256 salt" ")" "MintParams(" "uint256 mintPrice," "uint256 maxTotalMintableByWallet," "uint256 startTime,"
    "uint256 endTime," "uint256 dropStageIndex," "uint256 maxTokenSupplyForStage," "uint256 feeBps,"
    "bool restrictFeeRecipients" ")"
);
```


### _MINT_PARAMS_TYPEHASH

```solidity
bytes32 internal constant _MINT_PARAMS_TYPEHASH = keccak256(
    "MintParams(" "uint256 mintPrice," "uint256 maxTotalMintableByWallet," "uint256 startTime," "uint256 endTime,"
    "uint256 dropStageIndex," "uint256 maxTokenSupplyForStage," "uint256 feeBps," "bool restrictFeeRecipients" ")"
);
```


### _EIP_712_DOMAIN_TYPEHASH

```solidity
bytes32 internal constant _EIP_712_DOMAIN_TYPEHASH =
    keccak256("EIP712Domain(" "string name," "string version," "uint256 chainId," "address verifyingContract" ")");
```


### _NAME_HASH

```solidity
bytes32 internal constant _NAME_HASH = keccak256("SeaDrop");
```


### _VERSION_HASH

```solidity
bytes32 internal constant _VERSION_HASH = keccak256("1.0");
```


### _CHAIN_ID

```solidity
uint256 internal immutable _CHAIN_ID = block.chainid;
```


### _DOMAIN_SEPARATOR

```solidity
bytes32 internal immutable _DOMAIN_SEPARATOR;
```


### _UNLIMITED_MAX_TOKEN_SUPPLY_FOR_STAGE
Constant for an unlimited `maxTokenSupplyForStage`.
Used in `mintPublic` where no `maxTokenSupplyForStage`
is stored in the `PublicDrop` struct.


```solidity
uint256 internal constant _UNLIMITED_MAX_TOKEN_SUPPLY_FOR_STAGE = type(uint256).max;
```


### _PUBLIC_DROP_STAGE_INDEX
Constant for a public mint's `dropStageIndex`.
Used in `mintPublic` where no `dropStageIndex`
is stored in the `PublicDrop` struct.


```solidity
uint256 internal constant _PUBLIC_DROP_STAGE_INDEX = 0;
```


## Functions
### onlyINonFungibleSeaDropToken

Ensure only tokens implementing INonFungibleSeaDropToken can
call the update methods.


```solidity
modifier onlyINonFungibleSeaDropToken() virtual;
```

### constructor

Constructor for the contract deployment.


```solidity
constructor();
```

### mintPublic

Mint a public drop.


```solidity
function mintPublic(
    address nftContract,
    address feeRecipient,
    address minterIfNotPayer,
    uint256 quantity,
    uint16 provFeeBps,
    address provFeeRecipient
) external payable override;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`nftContract`|`address`|      The nft contract to mint.|
|`feeRecipient`|`address`|     The fee recipient.|
|`minterIfNotPayer`|`address`| The mint recipient if different than the payer.|
|`quantity`|`uint256`|         The number of tokens to mint.|
|`provFeeBps`|`uint16`|       The fee basis point for provenance.|
|`provFeeRecipient`|`address`| The provenance multisig wallet.|


### mintAllowList

Mint from an allow list.


```solidity
function mintAllowList(
    address nftContract,
    address feeRecipient,
    address minterIfNotPayer,
    uint256 quantity,
    MintParams calldata mintParams,
    bytes32[] calldata proof,
    uint16 provFeeBps,
    address provFeeRecipient
) external payable override;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`nftContract`|`address`|      The nft contract to mint.|
|`feeRecipient`|`address`|     The fee recipient.|
|`minterIfNotPayer`|`address`| The mint recipient if different than the payer.|
|`quantity`|`uint256`|         The number of tokens to mint.|
|`mintParams`|`MintParams`|       The mint parameters.|
|`proof`|`bytes32[]`|            The proof for the leaf of the allow list.|
|`provFeeBps`|`uint16`|       The fee basis point for provenance.|
|`provFeeRecipient`|`address`| The provenance multisig wallet.|


### mintSigned

Mint with a server-side signature.
Note that a signature can only be used once.


```solidity
function mintSigned(
    address nftContract,
    address feeRecipient,
    address minterIfNotPayer,
    uint256 quantity,
    MintParams calldata mintParams,
    uint256 salt,
    bytes calldata signature,
    uint16 provFeeBps,
    address provFeeRecipient
) external payable override;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`nftContract`|`address`|      The nft contract to mint.|
|`feeRecipient`|`address`|     The fee recipient.|
|`minterIfNotPayer`|`address`| The mint recipient if different than the payer.|
|`quantity`|`uint256`|         The number of tokens to mint.|
|`mintParams`|`MintParams`|       The mint parameters.|
|`salt`|`uint256`|             The salt for the signed mint.|
|`signature`|`bytes`|        The server-side signature, must be an allowed signer.|
|`provFeeBps`|`uint16`|       The fee basis point for provenance.|
|`provFeeRecipient`|`address`| The provenance multisig wallet.|


### _validateSignerAndParams

Enforce stored parameters for signed mints to mitigate
the effects of a malicious signer.


```solidity
function _validateSignerAndParams(address nftContract, MintParams memory mintParams, address signer) internal view;
```

### mintAllowedTokenHolder

Mint as an allowed token holder.
This will mark the token ids as redeemed and will revert if the
same token id is attempted to be redeemed twice.


```solidity
function mintAllowedTokenHolder(
    address nftContract,
    address feeRecipient,
    address minterIfNotPayer,
    TokenGatedMintParams calldata mintParams,
    uint16 provFeeBps,
    address provFeeRecipient
) external payable override;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`nftContract`|`address`|      The nft contract to mint.|
|`feeRecipient`|`address`|     The fee recipient.|
|`minterIfNotPayer`|`address`| The mint recipient if different than the payer.|
|`mintParams`|`TokenGatedMintParams`|       The token gated mint params.|
|`provFeeBps`|`uint16`|       The fee basis point for provenance.|
|`provFeeRecipient`|`address`| The provenance multisig wallet.|


### _checkActive

Check that the drop stage is active.


```solidity
function _checkActive(uint256 startTime, uint256 endTime) internal view;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`startTime`|`uint256`|The drop stage start time.|
|`endTime`|`uint256`|  The drop stage end time.|


### _checkFeeRecipientIsAllowed

Check that the fee recipient is allowed.


```solidity
function _checkFeeRecipientIsAllowed(address nftContract, address feeRecipient, bool restrictFeeRecipients)
    internal
    view;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`nftContract`|`address`|          The nft contract.|
|`feeRecipient`|`address`|         The fee recipient.|
|`restrictFeeRecipients`|`bool`|If the fee recipients are restricted.|


### _checkMintQuantity

Check that the wallet is allowed to mint the desired quantity.


```solidity
function _checkMintQuantity(
    address nftContract,
    address minter,
    uint256 quantity,
    uint256 maxTotalMintableByWallet,
    uint256 maxTokenSupplyForStage
) internal view;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`nftContract`|`address`|             The nft contract.|
|`minter`|`address`|                  The mint recipient.|
|`quantity`|`uint256`|                The number of tokens to mint.|
|`maxTotalMintableByWallet`|`uint256`|The max allowed mints per wallet.|
|`maxTokenSupplyForStage`|`uint256`|  The max token supply for the drop stage.|


### _checkCorrectPayment

Revert if the payment is not the quantity times the mint price.


```solidity
function _checkCorrectPayment(uint256 quantity, uint256 mintPrice) internal view;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`quantity`|`uint256`| The number of tokens to mint.|
|`mintPrice`|`uint256`|The mint price per token.|


### _splitPayout

Split the payment payout for the creator and fee recipient.


```solidity
function _splitPayout(
    address nftContract,
    address feeRecipient,
    address provFeeRecipient,
    uint256 feeBps,
    uint256 provFeeBps
) internal;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`nftContract`|`address`| The nft contract.|
|`feeRecipient`|`address`|The fee recipient.|
|`provFeeRecipient`|`address`||
|`feeBps`|`uint256`|      The fee basis points.|
|`provFeeBps`|`uint256`|  The fee basis point for provenance.|


### _mintAndPay

Mints a number of tokens, splits the payment,
and emits an event.


```solidity
function _mintAndPay(
    address nftContract,
    address minter,
    uint256 quantity,
    uint256 mintPrice,
    uint256 dropStageIndex,
    uint256 feeBps,
    address feeRecipient,
    uint256 provFeeBps,
    address provFeeRecipient
) internal nonReentrant;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`nftContract`|`address`|      The nft contract.|
|`minter`|`address`|           The mint recipient.|
|`quantity`|`uint256`|         The number of tokens to mint.|
|`mintPrice`|`uint256`|        The mint price per token.|
|`dropStageIndex`|`uint256`|   The drop stage index.|
|`feeBps`|`uint256`|           The fee basis points.|
|`feeRecipient`|`address`|     The fee recipient.|
|`provFeeBps`|`uint256`|       The fee basis point for provenance.|
|`provFeeRecipient`|`address`| The provenance multisig wallet.|


### _domainSeparator

*Internal view function to get the EIP-712 domain separator. If the
chainId matches the chainId set on deployment, the cached domain
separator will be returned; otherwise, it will be derived from
scratch.*


```solidity
function _domainSeparator() internal view returns (bytes32);
```
**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`bytes32`|The domain separator.|


### _deriveDomainSeparator

*Internal view function to derive the EIP-712 domain separator.*


```solidity
function _deriveDomainSeparator() internal view returns (bytes32);
```
**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`bytes32`|The derived domain separator.|


### getPublicDrop

Returns the public drop data for the nft contract.


```solidity
function getPublicDrop(address nftContract) external view returns (PublicDrop memory);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`nftContract`|`address`|The nft contract.|


### getCreatorPayoutAddress

Returns the creator payout address for the nft contract.


```solidity
function getCreatorPayoutAddress(address nftContract) external view returns (address);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`nftContract`|`address`|The nft contract.|


### getAllowListMerkleRoot

Returns the allow list merkle root for the nft contract.


```solidity
function getAllowListMerkleRoot(address nftContract) external view returns (bytes32);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`nftContract`|`address`|The nft contract.|


### getFeeRecipientIsAllowed

Returns if the specified fee recipient is allowed
for the nft contract.


```solidity
function getFeeRecipientIsAllowed(address nftContract, address feeRecipient) external view returns (bool);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`nftContract`|`address`|The nft contract.|
|`feeRecipient`|`address`||


### getAllowedFeeRecipients

Returns an enumeration of allowed fee recipients for an
nft contract when fee recipients are enforced.


```solidity
function getAllowedFeeRecipients(address nftContract) external view returns (address[] memory);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`nftContract`|`address`|The nft contract.|


### getSigners

Returns the server-side signers for the nft contract.


```solidity
function getSigners(address nftContract) external view returns (address[] memory);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`nftContract`|`address`|The nft contract.|


### getSignedMintValidationParams

Returns the struct of SignedMintValidationParams for a signer.


```solidity
function getSignedMintValidationParams(address nftContract, address signer)
    external
    view
    returns (SignedMintValidationParams memory);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`nftContract`|`address`|The nft contract.|
|`signer`|`address`|     The signer.|


### getPayers

Returns the payers for the nft contract.


```solidity
function getPayers(address nftContract) external view returns (address[] memory);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`nftContract`|`address`|The nft contract.|


### getPayerIsAllowed

Returns if the specified payer is allowed
for the nft contract.


```solidity
function getPayerIsAllowed(address nftContract, address payer) external view returns (bool);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`nftContract`|`address`|The nft contract.|
|`payer`|`address`|      The payer.|


### getTokenGatedAllowedTokens

Returns the allowed token gated drop tokens for the nft contract.


```solidity
function getTokenGatedAllowedTokens(address nftContract) external view returns (address[] memory);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`nftContract`|`address`|The nft contract.|


### getTokenGatedDrop

Returns the token gated drop data for the nft contract
and token gated nft.


```solidity
function getTokenGatedDrop(address nftContract, address allowedNftToken)
    external
    view
    returns (TokenGatedDropStage memory);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`nftContract`|`address`|    The nft contract.|
|`allowedNftToken`|`address`|The token gated nft token.|


### getAllowedNftTokenIdIsRedeemed

Returns whether the token id for a token gated drop has been
redeemed.


```solidity
function getAllowedNftTokenIdIsRedeemed(address nftContract, address allowedNftToken, uint256 allowedNftTokenId)
    external
    view
    returns (bool);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`nftContract`|`address`|      The nft contract.|
|`allowedNftToken`|`address`|  The token gated nft token.|
|`allowedNftTokenId`|`uint256`|The token gated nft token id to check.|


### updateDropURI

Emits an event to notify update of the drop URI.
This method assume msg.sender is an nft contract and its
ERC165 interface id matches INonFungibleSeaDropToken.
Note: Be sure only authorized users can call this from
token contracts that implement INonFungibleSeaDropToken.


```solidity
function updateDropURI(string calldata dropURI) external onlyINonFungibleSeaDropToken;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`dropURI`|`string`|The new drop URI.|


### updatePublicDrop

Updates the public drop data for the nft contract
and emits an event.
This method assume msg.sender is an nft contract and its
ERC165 interface id matches INonFungibleSeaDropToken.
Note: Be sure only authorized users can call this from
token contracts that implement INonFungibleSeaDropToken.


```solidity
function updatePublicDrop(PublicDrop calldata publicDrop) external override onlyINonFungibleSeaDropToken;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`publicDrop`|`PublicDrop`|The public drop data.|


### updateAllowList

Updates the allow list merkle root for the nft contract
and emits an event.
This method assume msg.sender is an nft contract and its
ERC165 interface id matches INonFungibleSeaDropToken.
Note: Be sure only authorized users can call this from
token contracts that implement INonFungibleSeaDropToken.


```solidity
function updateAllowList(AllowListData calldata allowListData) external override onlyINonFungibleSeaDropToken;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`allowListData`|`AllowListData`|The allow list data.|


### updateTokenGatedDrop

Updates the token gated drop stage for the nft contract
and emits an event.
This method assume msg.sender is an nft contract and its
ERC165 interface id matches INonFungibleSeaDropToken.
Note: Be sure only authorized users can call this from
token contracts that implement INonFungibleSeaDropToken.
Note: If two INonFungibleSeaDropToken tokens are doing
simultaneous token gated drop promotions for each other,
they can be minted by the same actor until
`maxTokenSupplyForStage` is reached. Please ensure the
`allowedNftToken` is not running an active drop during
the `dropStage` time period.


```solidity
function updateTokenGatedDrop(address allowedNftToken, TokenGatedDropStage calldata dropStage)
    external
    override
    onlyINonFungibleSeaDropToken;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`allowedNftToken`|`address`|The token gated nft token.|
|`dropStage`|`TokenGatedDropStage`|      The token gated drop stage data.|


### updateCreatorPayoutAddress

Updates the creator payout address and emits an event.
This method assume msg.sender is an nft contract and its
ERC165 interface id matches INonFungibleSeaDropToken.
Note: Be sure only authorized users can call this from
token contracts that implement INonFungibleSeaDropToken.


```solidity
function updateCreatorPayoutAddress(address payoutAddress) external onlyINonFungibleSeaDropToken;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`payoutAddress`|`address`|The creator payout address.|


### updateAllowedFeeRecipient

Updates the allowed fee recipient and emits an event.
This method assume msg.sender is an nft contract and its
ERC165 interface id matches INonFungibleSeaDropToken.
Note: Be sure only authorized users can call this from
token contracts that implement INonFungibleSeaDropToken.


```solidity
function updateAllowedFeeRecipient(address feeRecipient, bool allowed) external onlyINonFungibleSeaDropToken;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`feeRecipient`|`address`|The fee recipient.|
|`allowed`|`bool`|     If the fee recipient is allowed.|


### updateSignedMintValidationParams

Updates the allowed server-side signers and emits an event.
This method assume msg.sender is an nft contract and its
ERC165 interface id matches INonFungibleSeaDropToken.
Note: Be sure only authorized users can call this from
token contracts that implement INonFungibleSeaDropToken.


```solidity
function updateSignedMintValidationParams(
    address signer,
    SignedMintValidationParams calldata signedMintValidationParams
) external onlyINonFungibleSeaDropToken;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`signer`|`address`|                    The signer to update.|
|`signedMintValidationParams`|`SignedMintValidationParams`|Minimum and maximum parameters to enforce for signed mints.|


### updatePayer

Updates the allowed payer and emits an event.
This method assume msg.sender is an nft contract and its
ERC165 interface id matches INonFungibleSeaDropToken.
Note: Be sure only authorized users can call this from
token contracts that implement INonFungibleSeaDropToken.


```solidity
function updatePayer(address payer, bool allowed) external onlyINonFungibleSeaDropToken;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`payer`|`address`|  The payer to add or remove.|
|`allowed`|`bool`|Whether to add or remove the payer.|


### _removeFromEnumeration

Remove an address from a supplied enumeration.


```solidity
function _removeFromEnumeration(address toRemove, address[] storage enumeration) internal;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`toRemove`|`address`|   The address to remove.|
|`enumeration`|`address[]`|The enumerated addresses to parse.|


### _getDigest

Verify an EIP-712 signature by recreating the data structure
that we signed on the client side, and then using that to recover
the address that signed the signature for this data.


```solidity
function _getDigest(
    address nftContract,
    address minter,
    address feeRecipient,
    MintParams memory mintParams,
    uint256 salt
) internal view returns (bytes32 digest);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`nftContract`|`address`| The nft contract.|
|`minter`|`address`|      The mint recipient.|
|`feeRecipient`|`address`|The fee recipient.|
|`mintParams`|`MintParams`|  The mint params.|
|`salt`|`uint256`|        The salt for the signed mint.|


### _cast

*Internal pure function to cast a `bool` value to a `uint256` value.*


```solidity
function _cast(bool b) internal pure returns (uint256 u);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`b`|`bool`|The `bool` value to cast.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`u`|`uint256`|The `uint256` value.|


