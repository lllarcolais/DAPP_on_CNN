const { ethers } = require('hardhat')

const main = async () => {
    const Rating = await ethers.getContractFactory('Ratings')
    const rt = await Rating.deploy("0x673E3eBEE1a29B6Dd721f18A473056C5Cf960Adc")
    await rt.deployed()

    console.log('The contract is deployed successfully, address:', rt.address)
}

main()
    .then(() => process.exit(0))
    .catch(error => {
        console.error(error)
        process.exit(1)
    })