import {buildModule} from '@nomicfoundation/hardhat-ignition/modules'

const GachaponModule = buildModule('GachaponModule', (m) => {
  const gachapon = m.contract('Gachapon', [
    /* コンストラクタの引数 */
  ])

  return {gachapon}
})

export default GachaponModule
