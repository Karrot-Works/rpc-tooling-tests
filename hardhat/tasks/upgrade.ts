import "@nomicfoundation/hardhat-toolbox";
import { task } from "hardhat/config";
import { TaskArguments } from "hardhat/types";

import * as fs from "fs";
import * as path from "path";

task("upgrade:TestTokenV2", "Upgrades the contract")
.setAction(async (taskArgs: TaskArguments, hre) => {
        
    const filePath = path.join(__dirname,".." ,"deployed_addresses.json");

    if (!fs.existsSync(filePath)) {
      console.error("deployed_addresses.json file not found.");
      process.exit(1);
    }

    const rawData = fs.readFileSync(filePath);
    const addresses = JSON.parse(rawData.toString());

    if (!addresses.TestTokenV1) {
      console.error("TestTokenV1 address not found in deployed_addresses.json.");
      process.exit(1);
    }

    const TestTokenV1Address = addresses.TestTokenV1;

    const TestTokenV2ContractFactory = await hre.ethers.getContractFactory("TestTokenV2");
    const TestTokenV2Contract = await hre.upgrades.upgradeProxy(TestTokenV1Address, TestTokenV2ContractFactory);

    const address = await TestTokenV2Contract.getAddress();

    console.log("TestTokenV2 deployed to:", address);
});
