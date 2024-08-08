
# Load environment variables from .env file
ifneq (,$(wildcard ./.env))
    include .env
    export $(shell sed 's/=.*//' .env)
endif

# Ensure NETWORK is set
check-network:
ifndef NETWORK
	$(error NETWORK environment variable is not set. Please set it and try again.)
endif
	@echo "NETWORK is set to $(NETWORK)"
	@echo "RPC is $(RPC_URL)"

# Hardhat tasks
deploy-hardhat-contracts:
	@echo "Running Hardhat"
	@cd hardhat && \
	echo "Compile the contracts..." && \
	npx hardhat compile && \
	echo "Deploying TestToken contract..." && \
	npx hardhat deploy:TestToken --network $(NETWORK) && \
	echo "Deploying TestTokenV1 contract..." && \
	npx hardhat deploy:TestTokenV1 --network $(NETWORK)

upgrade-hardhat-contracts:
	@echo "Upgrading Hardhat contracts"
	@cd hardhat && \
	echo "Upgrade TestTokenV1 contract to TestTokenV2..." && \
	npx hardhat upgrade:TestTokenV2 --network $(NETWORK)

# Foundry tasks
test-foundry:
	@echo "Running forge test"
	@cd foundry && forge test

deploy-foundry-contracts:
	@echo "Deploying contracts using Foundry"
	@cd foundry && forge script script/DeployTestToken.s.sol --rpc-url $(RPC_URL) --broadcast --private-key $(PRIVATE_KEY)

.PHONY: check-network deploy-hardhat test-foundry deploy-foundry all

all: check-network deploy-hardhat-contracts test-foundry deploy-foundry-contracts
