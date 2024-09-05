import {task} from 'hardhat/config'
import {ethers} from 'ethers'
import {ABI} from './const/abi'

task('add', 'Adds an item to the contract')
  .addParam('contractAddress', "The contract's address")
  .setAction(async (taskArgs) => {
    const provider = new ethers.JsonRpcProvider()
    const signer = await provider.getSigner()

    const contract = new ethers.Contract(taskArgs.contractAddress, ABI, signer)

    const stock = ['🍎', '🍊', '🍋', '🍒', '🍇', '🍉', '🍓', '🍑', '🥭', '🍍']

    try {
      console.info(`ガチャポンに景品を追加しています...🎰`)
      const tx = await contract.addItems(stock)
      await tx.wait()

      console.info('正常に追加されました！🎉')
      console.table(stock)
    } catch {
      console.error('おっと、何かがうまくいかなかったようです...😢')
    }
  })
