# AllowListData
[Git Source](https://github.com/Provenance-Market/Provenance-AI-Backend-v2/blob/fbadee5cddd353412cd3f65d2fe397629bb40751/src/lib/SeaDropStructs.sol)

A struct defining allow list data (for minting an allow list).


```solidity
struct AllowListData {
    bytes32 merkleRoot;
    string[] publicKeyURIs;
    string allowListURI;
}
```

