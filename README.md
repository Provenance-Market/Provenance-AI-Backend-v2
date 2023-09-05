<h1 align="center">Provenance Back End V2</h1>
<p>
  <img alt="Version" src="https://img.shields.io/badge/version-2.0.0-blue.svg?cacheSeconds=2592000" />
  <a href="https://github.com/Provenance-Market/Provenance-AI-Backend-v2" target="_blank">
    <img alt="Documentation" src="https://img.shields.io/badge/documentation-yes-brightgreen.svg" />
  </a>
  <a href="#" target="_blank">
    <img alt="License: MIT" src="https://img.shields.io/badge/License-MIT-yellow.svg" />
  </a>
</p>

> NFT marketplace for AI-generated personalized artwork

## Links

🏠 [Homepage](https://app.prov.ai) \

## Setup

To install dependencies:

```sh
forge install
```

Configure keys in your `.env`:

```.env
ETHEREUM_RPC_URL="get from alchemy; only needed for tests"
ANVIL_RPC_URL="http://127.0.0.1:8545"
SEPOLIA_RPC_URL="https://eth-sepolia.g.alchemy.com/v2/{API_KEY}"
PRIVATE_KEY="Metamask account"
POLYGONSCAN_API_KEY=""
ETHERSCAN_API_KEY=""
```

## Foundry Tests

To run tests:

```sh
forge test
```

To run gas snapshot:

```sh
forge snapshot
```

The following modifiers are also available:

- Level 2 (-vv): Logs emitted during tests are also displayed.
- Level 3 (-vvv): Stack traces for failing tests are also displayed.
- Level 4 (-vvvv): Stack traces for all tests are displayed, and setup traces for failing tests are displayed.
- Level 5 (-vvvvv): Stack traces and setup traces are always displayed.

```bash
forge test  -vv
```

For more information on foundry testing and use, see [Foundry Book installation instructions](https://book.getfoundry.sh/getting-started/installation).

## Code Style

To run lint checks:

```sh
yarn lint:check
```

Lint checks utilize prettier, prettier-plugin-solidity, and solhint.

## Run Project Locally

1. Run development blockchain

```sh
anvil
```

2. Add network to MetaMask or whichever wallet to connect the [front-end site](https://github.com/Provenance-Market/Provenace-AI-Frontend)

- you'll need the following info to add the network:
  - RPC URL: `http://127.0.0.1:8545`
  - chain ID: `31337`
  - currency symbol: `ETH`

3. Import the anvil accounts into MetaMask to interact with on the front end

4. Deploy SeaDrop contract

- The private key used is the first anvil account, but feel free to change it
- Source the `.env` file to use variables like $ANVIL_RPC_URL

```sh
forge create --rpc-url http://127.0.0.1:8545 src/SeaDrop.sol:SeaDrop --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
```

- copy the address of the deployed SeaDrop contract and paste it as the `seadrop` address in the deploy script, `script/DeployProvNFTCollectionAnvil.s.sol`
  - this is already done, but check that the address matches

5. Deploy Collection contract

```sh
forge script script/DeployProvNFTCollectionAnvil.s.sol --rpc-url http://127.0.0.1:8545 --broadcast -vvvv --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
```

## Sepolia Deployment & Verification

1. Deploy SeaDrop contract

- Source `.env` for the environment variables

```sh
forge create src/SeaDrop.sol:SeaDrop --rpc-url $SEPOLIA_RPC_URL -vvvv --private-key $PRIVATE_KEY --etherscan-api-key $ETHERSCAN_API_KEY --verify --retries 10
```

2. Deploy Collection contract

- Ensure our own SeaDrop address is provided in the deploy script

```sh
forge script script/DeployProvNFTCollection.s.sol --rpc-url $SEPOLIA_RPC_URL --broadcast -vvvv --private-key $PRIVATE_KEY --etherscan-api-key $ETHERSCAN_API_KEY --verify --retries 10
```

## Helpful Contract Functions

All these methods will be called on the collection contract because of inheretance, besides the functions defined in the factory contract

| Function                   | Parameters                                              | Defined In Contract    | Description                                                     |
| -------------------------- | ------------------------------------------------------- | ---------------------- | --------------------------------------------------------------- |
| imageGenerationPayment     | uint256 \_cost, address \_owner, address \_multiSig     | ProvNFTCollection      | Only allows owner to generate images                            |
| tokenURI                   | uint256 tokenId                                         | ERC721SeaDrop          | Returns just the base URI                                       |
| mintSeaDrop                | address minter, uint256 quantity                        | ERC721SeaDrop          | Lets only the collection owner to add NFTs to their collection  |
| updatePublicDrop           | address seaDropImpl, PublicDrop calldata publicDrop     | ERC721SeaDrop          | Lets the owner set their drop schedule and drop earnings        |
| updateCreatorPayoutAddress | address seaDropImpl, address payoutAddress              | ERC721SeaDrop          | Set the creator payout address for this collection on SeaDrop   |
| updateAllowedFeeRecipient  | address seaDropImpl, address feeRecipient, bool allowed | ERC721SeaDrop          | Set the OpenSea address that will collect the service fees      |
| setBaseURI                 | string newBaseURI                                       | ERC721ContractMetadata | Sets the base URI for the token metadata and emits an event     |
| setMaxSupply               | uint256 newMaxSupply                                    | ERC721ContractMetadata | Sets the max amount of NFTs that can be added to the collection |
| setRoyaltyInfo             | RoyaltyInfo newInfo                                     | ERC721ContractMetadata | Sets the address and basis points for royalties                 |
| name                       |                                                         | ERC721A                | View the collection name                                        |
| symbol                     |                                                         | ERC721A                | View the collection symbol                                      |
| totalSupply                |                                                         | ERC721A                | View total number of tokens in existence                        |
| balanceOf                  | address owner                                           | ERC721A                | View the number of tokens in `owner`'s account                  |
| tokenURI                   | uint256 tokenId                                         | ERC721A                | View the URI for any NFT in a collection                        |
| approve                    | address operator, uint256 tokenId                       | ERC721A                | Allows an address to transfer NFT on behalf of the owner        |
| safeTransferFrom           | address from, address to, uint256 tokenId               | ERC721A                | Approved caller can transfer NFT                                |

## Authors

👤 [**Eddie**](https://github.com/Ed-Marcavage), [**AJ**](https://github.com/aaronjan98), [**Jake**](https://github.com/masonjake), [**Rohith**](https://github.com/Rohith09)

## 🤝 Contributing

Contributions, issues and feature requests are welcome! \
Feel free to check [issues page](https://github.com/Provenance-Market/Provenace-AI-Backend/issues).

## Show your support

Give a ⭐️ if this project helped you!
