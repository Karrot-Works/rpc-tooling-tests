
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
deploy-hardhat:
	@echo "Running Hardhat"
	@cd hardhat && \
	echo "Deploying TestToken contract..." && \
	npx hardhat deploy:TestToken --network $(NETWORK) && \
	echo "Deploying TestTokenV1 contract..." && \
	npx hardhat deploy:TestTokenV1 --network $(NETWORK) && \
	echo "Upgrade TestTokenV1 contract to TestTokenV2..." && \
	npx hardhat upgrade:TestTokenV2 --network $(NETWORK) && \
	echo "Deploying contract using Hardhat Ignition..." && \
	npx hardhat ignition deploy ./ignition/modules/Lock.ts --network $(NETWORK)

# Foundry tasks
test-foundry:
	@echo "Running forge test"
	@cd foundry && forge test

deploy-foundry:
	@echo "Deploying contracts using Foundry"
	@cd foundry && forge script script/DeployTestToken.s.sol --rpc-url $(RPC_URL) --broadcast --private-key $(PRIVATE_KEY)

.PHONY: check-network deploy-hardhat test-foundry deploy-foundry all

all: check-network deploy-hardhat test-foundry deploy-foundry
