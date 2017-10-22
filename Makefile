.PHONY: deps abi source build testrpc test

deps:
	npm install

abi:
	solc zeppelin-solidity=$(shell pwd -P)/node_modules/zeppelin-solidity/ contracts/EthearnalRepTokenCrowdsale.sol --abi | grep ":EthearnalRepTokenCrowdsale " -A2 | tail -n1 > build/EthearnalRepTokenCrowdsale.abi

source:
	node_modules/sol-merger/bin/sol-merger.js "contracts/*.sol" var/build
	cp var/build/EthearnalRepTokenCrowdsale.sol build

build: source abi

testrpc:
	testrpc -p 8544 \
		--account="0x7e9a1de56cce758c544ba5dea3a6347a4a01c453d81edc32c2385e9767f29505, 1000000000000000000000000000" \
		--account="0xf2029a2f20a9f57cd1a9a2a44c63d0c875f906c646f333b028cb6f1c38ef7db5, 1000000000000000000000000000" \
		--account="0x84f24b0dddc8262675927168bbbf8688f846bcaedc2618ae576d34c043401719, 1000000000000000000000000000" \
		--account="0x1fdc76364db4a4bcfad8f2c010995a96fcb98a165e34858665a234ba5471520b, 1000000000000000000000000000" \
		--account="0x1fdc76364db4a4bcfad8f2c010995a96fcb98a165e34858665a234ba5471520c, 1000000000000000000000000000" \
		--account="0x1fdc76364db4a4bcfad8f2c010995a96fcb98a165e34858665a234ba54715123, 1000000000000000000000000000" \
		--account="0x1fdc76364db4a4bcfad8f2c010995a96fcb98a165e34858665a234ba54715104, 1000000000000000000000000000" \

test:
	truffle test
