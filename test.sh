#!/bin/bash

# Check if the NETWORK environment variable is set
if [ -z "$NETWORK" ]; then
  echo "NETWORK environment variable is not set. Please set it and try again."
  exit 1
fi

echo "NETWORK is set to $NETWORK"
echo "Running Hardhat"

echo "Changing directory to hardhat"
cd hardhat

echo "Deploying TestToken contract..."
npx hardhat deploy:TestToken --network $NETWORK

echo "Deploying TestTokenV1 contract..."
npx hardhat deploy:TestTokenV1 --network $NETWORK

echo "Upgrade TestTokenV1 contract to TestTokenV2..."
npx hardhat upgrade:TestTokenV2 --network $NETWORK

echo "Deploying contract using Hardhat Ignition..."
npx hardhat ignition deploy ./ignition/modules/Lock.ts --network $NETWORK
