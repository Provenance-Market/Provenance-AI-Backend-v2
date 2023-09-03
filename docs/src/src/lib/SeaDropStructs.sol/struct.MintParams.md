# MintParams
[Git Source](https://github.com/Provenance-Market/Provenance-AI-Backend-v2/blob/fbadee5cddd353412cd3f65d2fe397629bb40751/src/lib/SeaDropStructs.sol)

A struct defining mint params for an allow list.
An allow list leaf will be composed of `msg.sender` and
the following params.
Note: Since feeBps is encoded in the leaf, backend should ensure
that feeBps is acceptable before generating a proof.


```solidity
struct MintParams {
    uint256 mintPrice;
    uint256 maxTotalMintableByWallet;
    uint256 startTime;
    uint256 endTime;
    uint256 dropStageIndex;
    uint256 maxTokenSupplyForStage;
    uint256 feeBps;
    bool restrictFeeRecipients;
}
```

