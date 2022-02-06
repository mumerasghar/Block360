
async function main() {

    const Block = await hre.ethers.getContractFactory('Block');
    const block = await Block.deploy();

    await block.deployed();

    console.log("block is deployed to:", block.address);
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.log(error);
        process.exit(1);
    })