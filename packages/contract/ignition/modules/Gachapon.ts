import {buildModule} from '@nomicfoundation/hardhat-ignition/modules'

const GachaponModule = buildModule('GachaponModule', (m) => {
  const gachapon = m.contract('Gachapon', ['Fruits Gacha'])

  return {gachapon}
})

export default GachaponModule
