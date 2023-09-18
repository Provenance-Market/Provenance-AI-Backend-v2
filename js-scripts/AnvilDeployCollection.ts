const { ethers } = require("ethers");
const fs = require("fs");
require("dotenv/config");

const provider = new ethers.providers.JsonRpcProvider(
  process.env.ANVIL_RPC_URL
);
const userAddress = "0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266";
const privateKey = process.env.ANVIL_PRIVATE_KEY;
const wallet = new ethers.Wallet(privateKey, provider);
const factoryAddress = "0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512";

const jsonFilePath = "./out/IProvNFTFactory.sol/IProvNFTFactory.json";
const jsonString = fs.readFileSync(jsonFilePath, "utf8");
const contractArtifact = JSON.parse(jsonString);
const contractAbi = contractArtifact.abi;

const factory = new ethers.Contract(factoryAddress, contractAbi, wallet);

async function createNFTCollection() {
  try {
    const tx = await factory.createNFTCollection(
      "Anvil Prov SeaDrop Collection",
      "APSC"
    );
    console.log("Transaction:", tx);

    const receipt = await tx.wait();
    console.log({ receipt });

    // Access the events emitted during the transaction
    const logs = receipt.logs;
    console.log("Logs:", logs);

    // Extract the address from the third log's data field
    const data = logs[2].data;
    const collectionAddress = "0x" + data.slice(-40);
    console.log("Collection Contract Address:", collectionAddress);
  } catch (error) {
    console.error("Error:", error);
  }
}

createNFTCollection();
