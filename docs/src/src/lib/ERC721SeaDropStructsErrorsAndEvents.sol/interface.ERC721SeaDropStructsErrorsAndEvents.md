# ERC721SeaDropStructsErrorsAndEvents
[Git Source](https://github.com/Provenance-Market/Provenance-AI-Backend-v2/blob/fbadee5cddd353412cd3f65d2fe397629bb40751/src/lib/ERC721SeaDropStructsErrorsAndEvents.sol)


## Events
### SeaDropTokenDeployed
An event to signify that a SeaDrop token contract was deployed.


```solidity
event SeaDropTokenDeployed();
```

## Errors
### MintQuantityExceedsMaxSupply
Revert with an error if mint exceeds the max supply.


```solidity
error MintQuantityExceedsMaxSupply(uint256 total, uint256 maxSupply);
```

### TokenGatedMismatch
Revert with an error if the number of token gated
allowedNftTokens doesn't match the length of supplied
drop stages.


```solidity
error TokenGatedMismatch();
```

### SignersMismatch
Revert with an error if the number of signers doesn't match
the length of supplied signedMintValidationParams


```solidity
error SignersMismatch();
```

## Structs
### MultiConfigureStruct
A struct to configure multiple contract options at a time.


```solidity
struct MultiConfigureStruct {
    uint256 maxSupply;
    string baseURI;
    string contractURI;
    address seaDropImpl;
    PublicDrop publicDrop;
    string dropURI;
    AllowListData allowListData;
    address creatorPayoutAddress;
    bytes32 provenanceHash;
    address[] allowedFeeRecipients;
    address[] disallowedFeeRecipients;
    address[] allowedPayers;
    address[] disallowedPayers;
    address[] tokenGatedAllowedNftTokens;
    TokenGatedDropStage[] tokenGatedDropStages;
    address[] disallowedTokenGatedAllowedNftTokens;
    address[] signers;
    SignedMintValidationParams[] signedMintValidationParams;
    address[] disallowedSigners;
}
```

