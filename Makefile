-include .env

.PHONY: all install update build test snapshot format anvil deployProv deployAnvil interactProv interactAnvil

DEFAULT_ANVIL_KEY := 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80

help:
	@echo "Usage:"
	@echo "  make deployProv [ARGS=...]\n    example: make deployProv ARGS=\"--network sepolia\""
	@echo "  make deployAnvil [ARGS=...]\n    example: make deployAnvil ARGS=\"--network sepolia\""
	@echo "  make interactProv [COLLECTION_ADDRESS=...]\n    example: make interactProv COLLECTION_ADDRESS=0x..."
	@echo "  make interactAnvil [COLLECTION_ADDRESS=...]\n    example: make interactAnvil COLLECTION_ADDRESS=0x..."

all: clean install update build

# Clean the repo
clean:
	@forge clean

# Install dependencies
install:
	@forge install

# Update Dependencies
update:
	@forge update

# Build the project
build:
	@forge build

# Run tests
test:
	@forge test -vv

# Run gas snapshot
snapshot:
	@forge snapshot

# Run lint checks
format:
	@yarn lint:check