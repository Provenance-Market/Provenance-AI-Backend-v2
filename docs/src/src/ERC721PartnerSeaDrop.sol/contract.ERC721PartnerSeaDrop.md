# ERC721PartnerSeaDrop
[Git Source](https://github.com/Provenance-Market/Provenance-AI-Backend-v2/blob/fbadee5cddd353412cd3f65d2fe397629bb40751/src/ERC721PartnerSeaDrop.sol)

**Inherits:**
[ERC721SeaDrop](/src/ERC721SeaDrop.sol/contract.ERC721SeaDrop.md), TwoStepAdministered

**Authors:**
James Wenzel (emo.eth), Ryan Ghods (ralxz.eth), Stephan Min (stephanm.eth)

ERC721PartnerSeaDrop is a token contract that contains methods
to properly interact with SeaDrop, with additional administrative
functionality tailored for business requirements around partnered
mints with off-chain agreements in place between two parties.
The "Owner" should control mint specifics such as price and start.
The "Administrator" should control fee parameters.
Otherwise, for ease of administration, either Owner or Administrator
should be able to configure mint parameters. They have the ability
to override each other's actions in many circumstances, which is
why the establishment of off-chain trust is important.
Note: An Administrator is not required to interface with SeaDrop.


## Functions
### constructor

Deploy the token contract with its name, symbol,
administrator, and allowed SeaDrop addresses.


```solidity
constructor(string memory name, string memory symbol, address administrator, address[] memory allowedSeaDrop)
    ERC721SeaDrop(name, symbol, allowedSeaDrop)
    TwoStepAdministered(administrator);
```

### mintSeaDrop

Mint tokens, restricted to the SeaDrop contract.


```solidity
function mintSeaDrop(address minter, uint256 quantity) public virtual override;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`minter`|`address`|  The address to mint to.|
|`quantity`|`uint256`|The number of tokens to mint.|


### updateAllowedSeaDrop

Update the allowed SeaDrop contracts.
Only the owner or administrator can use this function.


```solidity
function updateAllowedSeaDrop(address[] calldata allowedSeaDrop) external override onlyOwnerOrAdministrator;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`allowedSeaDrop`|`address[]`|The allowed SeaDrop addresses.|


### updatePublicDrop

Update the public drop data for this nft contract on SeaDrop.
Only the owner or administrator can use this function.
The administrator can only update `feeBps`.


```solidity
function updatePublicDrop(address seaDropImpl, PublicDrop calldata publicDrop)
    external
    virtual
    override
    onlyOwnerOrAdministrator;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`seaDropImpl`|`address`|The allowed SeaDrop contract.|
|`publicDrop`|`PublicDrop`| The public drop data.|


### updateAllowList

Update the allow list data for this nft contract on SeaDrop.
Only the owner or administrator can use this function.


```solidity
function updateAllowList(address seaDropImpl, AllowListData calldata allowListData)
    external
    virtual
    override
    onlyOwnerOrAdministrator;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`seaDropImpl`|`address`|  The allowed SeaDrop contract.|
|`allowListData`|`AllowListData`|The allow list data.|


### updateTokenGatedDrop

Update the token gated drop stage data for this nft contract
on SeaDrop.
Only the owner or administrator can use this function.
The administrator must first set `feeBps`.
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
    override
    onlyOwnerOrAdministrator;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`seaDropImpl`|`address`|    The allowed SeaDrop contract.|
|`allowedNftToken`|`address`|The allowed nft token.|
|`dropStage`|`TokenGatedDropStage`|      The token gated drop stage data.|


### updateDropURI

Update the drop URI for this nft contract on SeaDrop.
Only the owner or administrator can use this function.


```solidity
function updateDropURI(address seaDropImpl, string calldata dropURI)
    external
    virtual
    override
    onlyOwnerOrAdministrator;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`seaDropImpl`|`address`|The allowed SeaDrop contract.|
|`dropURI`|`string`|    The new drop URI.|


### updateAllowedFeeRecipient

Update the allowed fee recipient for this nft contract
on SeaDrop.
Only the administrator can set the allowed fee recipient.


```solidity
function updateAllowedFeeRecipient(address seaDropImpl, address feeRecipient, bool allowed)
    external
    override
    onlyAdministrator;
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
Only the owner or administrator can use this function.


```solidity
function updateSignedMintValidationParams(
    address seaDropImpl,
    address signer,
    SignedMintValidationParams memory signedMintValidationParams
) external virtual override onlyOwnerOrAdministrator;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`seaDropImpl`|`address`|               The allowed SeaDrop contract.|
|`signer`|`address`|                    The signer to update.|
|`signedMintValidationParams`|`SignedMintValidationParams`|Minimum and maximum parameters to enforce for signed mints.|


### updatePayer

Update the allowed payers for this nft contract on SeaDrop.
Only the owner or administrator can use this function.


```solidity
function updatePayer(address seaDropImpl, address payer, bool allowed)
    external
    virtual
    override
    onlyOwnerOrAdministrator;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`seaDropImpl`|`address`|The allowed SeaDrop contract.|
|`payer`|`address`|      The payer to update.|
|`allowed`|`bool`|    Whether the payer is allowed.|


## Errors
### AdministratorMustInitializeWithFee
To prevent Owner from overriding fees, Administrator must
first initialize with fee.


```solidity
error AdministratorMustInitializeWithFee();
```

