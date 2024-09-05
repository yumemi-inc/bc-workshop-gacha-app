import {task} from 'hardhat/config'
import {ethers} from 'ethers'
import {ABI} from './const/abi'

task('play', 'Play the gacha')
  .addParam('contractAddress', "The contract's address")
  .setAction(async (taskArgs) => {
    const provider = new ethers.JsonRpcProvider()
    const signer = await provider.getSigner()

    const contract = new ethers.Contract(taskArgs.contractAddress, ABI, signer)

    try {
      console.info('ガチャを引いています...🎰')
      const tx = await contract.play()
      await tx.wait()

      console.info('ジャーン！所有コレクションに景品が追加されました...🧸')

      const address = await signer.getAddress()
      const ownedItems = await contract.getOwnedCollection(address)
      console.table(ownedItems)
    } catch {
      console.error('おっと、何かがうまくいかなかったようです...😢')
    }
  })
