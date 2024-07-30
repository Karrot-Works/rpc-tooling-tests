import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import '@openzeppelin/hardhat-upgrades';

import "./tasks/deploy";
import "./tasks/upgrade";

import 'dotenv/config'

const privateKey = process.env.PRIVATE_KEY;
const config: HardhatUserConfig = {
  defaultNetwork: "hardhat",
  networks: {
    hardhat: {
    },
    "kakarot-sepolia": {
      url: "https://sepolia-rpc.kakarot.org",
      accounts: [privateKey!]
    },
    "base-sepolia": {
      url: "https://sepolia.base.org",
      accounts: [privateKey!]
    }
  },
  ignition: {
    blockPollingInterval: 3_000,
    timeBeforeBumpingFees: 3 * 60 * 1_000,
    maxFeeBumps: 0,
    requiredConfirmations: 1,
  },
  solidity: "0.8.24",
};

export default config;
