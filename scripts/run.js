const main = async () => {

    // Deploy the CoffeeContract
    const coffeeContractFactory = await hre.ethers.getContractFactory(
        "CoffeeContract"
    );
    const coffeeContract = await coffeeContractFactory.deploy({
        value: hre.ethers.utils.parseEther("0.1"),
    });
    await coffeeContract.deployed();
    console.log("Coffee Contract deployed to:", coffeeContract.address);

    // Get Contract balance
    let contractBalance = await hre.ethers.provider.getBalance(
        coffeeContract.address
    );
    console.log(
        "Contract balance:",
        hre.ethers.utils.formatEther(contractBalance)
    );

    // Make a transfer
    const transaction = await coffeeContract.transfer(
        ethers.utils.parseEther("0.005"),
        "This is coffee #1",
        "Pablo",
        { value: hre.ethers.utils.parseEther("0.1345"), gasLimit: 300000 }
    );
    await transaction.wait();

    // Get Contract balance
    contractBalance = await hre.ethers.provider.getBalance(
        coffeeContract.address
    );
    console.log(
        "Contract balance:",
        hre.ethers.utils.formatEther(contractBalance)
    );

    let allCoffee = await coffeeContract.getAllCoffee();
    console.log(allCoffee);

};

const runMain = async () => {
    try {
        await main();
        process.exit(0);
    } catch (error) {
        console.log(error);
        process.exit(1);
    }
};

runMain();