import type {HardhatUserConfig} from 'hardhat/config'
import '@nomicfoundation/hardhat-toolbox'
import {config as dotenvConfig} from 'dotenv'
dotenvConfig({path: __dirname + '/.env.local'})

import './scripts'

const config: HardhatUserConfig = {
  solidity: '0.8.24',
  networks: {
    sepolia: {
      url: 'https://rpc.sepolia.org/',
      accounts: process.env.PRIVATE_KEY ? [`0x${process.env.PRIVATE_KEY}`] : [],
    },
  },
  etherscan: {
    apiKey: process.env.ETHERSCAN_API_KEY,
  },
}

export default config
