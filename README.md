# Deploy a Smart Contract to buy me Coffee

## Requirements

Create a .env file and add your keys.
```
STAGING_ALCHEMY_KEY= https://eth-goerli.g.alchemy.com/v2/keyhere-
PRIVATE_KEY= Your Metamask PRivate key

```

## Deploy a contract

To deploy the contract run 
```
npx hardhat run scripts/deploy.js --network goerli
```

## Testing locally

Start a local node
```
npx hardhat node
```
Then run the run.js script
```
npx hardhat run scripts/run.js --network localhost
```