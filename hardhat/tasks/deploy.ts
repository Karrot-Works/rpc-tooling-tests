import "@nomicfoundation/hardhat-toolbox";
import { task } from "hardhat/config";
import { TaskArguments } from "hardhat/types";

import * as fs from "fs";
import * as path from "path";

task("deploy:TestToken", "Deploys the contract")
    .setAction(async (taskArgs: TaskArguments, hre) => {

        const TestTokenContract = await hre.ethers.getContractFactory("TestToken");
        const tx = await TestTokenContract.deploy("10000");

        const receipt = await tx.waitForDeployment();

        const address = await receipt.getAddress();

        console.log("TestToken deployed to:", address);

        // Save the address to a file
        saveAddressToFile("TestToken", address);
    });


task("deploy:TestTokenV1", "Deploys an upgradeable contract")
    .setAction(async (taskArgs: TaskArguments, hre) => {

        const TestTokenContractFactory = await hre.ethers.getContractFactory("TestTokenV1");

        const TestTokenContract = await hre.upgrades.deployProxy(TestTokenContractFactory, ["10000"]);

        const tx = await TestTokenContract.waitForDeployment();

        const address = await tx.getAddress();

        console.log("TestToken deployed to:", address);

        // Save the address to a file
        saveAddressToFile("TestTokenV1", address);
    });


function saveAddressToFile(contractName: string, address: string) {
    const filePath = path.join(__dirname, "..", "deployed_addresses.json");

    let addresses: { [key: string]: string } = {};

    // Check if the file exists and read the existing addresses
    if (fs.existsSync(filePath)) {
        const rawData = fs.readFileSync(filePath);
        addresses = JSON.parse(rawData.toString());
    }

    // Update the address for the given contract name
    addresses[contractName] = address;

    // Write the updated addresses back to the file
    fs.writeFileSync(filePath, JSON.stringify(addresses, null, 2));
    console.log(`Address of ${contractName} saved to ${filePath}`);
}
