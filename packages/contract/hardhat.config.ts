import type {HardhatUserConfig} from 'hardhat/config'
import '@nomicfoundation/hardhat-toolbox'

import './scripts'

const config: HardhatUserConfig = {
  solidity: '0.8.24',
  networks: {
    sepolia: {
      url: 'https://1rpc.io/sepolia',
      accounts:
        process.env.PRIVATE_KEY && process.env.PRIVATE_KEY.length === 64
          ? [process.env.PRIVATE_KEY]
          : [],
    },
  },
  etherscan: {
    apiKey: process.env.ETHERSCAN_API_KEY,
  },
}

export default config
