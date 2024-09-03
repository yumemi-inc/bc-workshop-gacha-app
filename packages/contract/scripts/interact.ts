import {task} from 'hardhat/config'
import {ethers} from 'ethers'

task('interact', 'Executes a contract which is deployed on hardhat network')
  .addParam('contractAddress', "The contract's address")
  .setAction(async (taskArgs) => {
    const provider = new ethers.JsonRpcProvider()
    const abi = [] // コントラクトのABIを記述

    const contract = new ethers.Contract(taskArgs.contractAddress, abi, provider)

    const result = await contract.play()

    console.log('ガチャ結果: ', result)
  })
