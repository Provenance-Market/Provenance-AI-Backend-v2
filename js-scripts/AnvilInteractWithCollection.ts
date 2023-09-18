const { ethers } = require("ethers");
const fs = require("fs");
require("dotenv/config");

// Connect to the network
// let provider = ethers.getDefaultProvider(process.env.ANVIL_RPC_URL);
const provider = new ethers.providers.JsonRpcProvider(
  process.env.ANVIL_RPC_URL
);

// The address of the collection owner's account and the private key
let userAddress = "0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266";
let privateKey = process.env.ANVIL_PRIVATE_KEY;

// Create a wallet
let wallet = new ethers.Wallet(privateKey, provider);

// The address of the collection contract you want to interact with on anvil
let contractAddress = "0xCafac3dD18aC6c6e92c921884f9E4176737C052c";

// Read the ABI from the JSON file
const jsonFilePath = "./out/ProvNFTCollection.sol/ProvNFTCollection.json";
const jsonString = fs.readFileSync(jsonFilePath, "utf8");
const contractArtifact = JSON.parse(jsonString);
const contractAbi = contractArtifact.abi;

// Create a contract instance
let contract = new ethers.Contract(contractAddress, contractAbi, wallet);

async function interactWithContract() {
  try {
    // Configure Collection
    let tx = await contract.setMaxSupply(100, { gasLimit: 100000 });
    console.log("Transaction:", tx);

    // let functionSignature = ethers.utils
    //   .id("setMaxSupply(uint256)")
    //   .slice(0, 10);
    // let functionArguments = ethers.utils.defaultAbiCoder.decode(
    //   ["uint256"],
    //   "0x" + tx.data.slice(10)
    // );

    // console.log("Function Signature:", functionSignature);
    // console.log("Function Arguments:", functionArguments);
  } catch (error) {
    if (error.revert && error.revert.reason) {
      console.log("Revert Reason:", error.revert.reason);
    } else {
      console.log("Error:", error);
    }
  }
}

// Call the async function
interactWithContract();
