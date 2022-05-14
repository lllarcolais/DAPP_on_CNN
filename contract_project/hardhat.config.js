require("@nomiclabs/hardhat-waffle")
require("@nomiclabs/hardhat-ethers")
//require('@openzeppelin/hardhat-upgrades')
//require("dotenv").config()
/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  solidity: "0.8.4",
  networks: {
    Huygens_dev: {
      url: "http://18.182.45.18:8765",
      accounts: [
        "81F64ABB138E11AB7FA97C290300CA4586CE05D5107FAF240B6F2296A4F8935B"
      ]
    },
    Huygens: {
      url: "HUYGENS_URL=http://13.212.177.203:8765",
      accounts: [
        "81F64ABB138E11AB7FA97C290300CA4586CE05D5107FAF240B6F2296A4F8935B"
      ]
    },
  }
};

