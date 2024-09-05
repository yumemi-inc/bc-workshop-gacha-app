// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

/*
  ==========-==========-==========-==========-==========-==========
  ガチャポンの機能要件

  1. ガチャを回して景品を獲得することができる
    a. 景品はランダムに選ばれる
    b. 獲得された景品は、ガチャポンの中から取り除かれる
  2. ガチャの景品を補充できる
    a. ガチャポンの管理人のみが実行可能
  3. 獲得した景品を確認できる
  ==========-==========-==========-==========-==========-==========
*/

/*
  変数、関数の可視性について: https://docs.soliditylang.org/en/latest/contracts.html#state-variable-visibility

  | 修飾子       | コントラクト内から呼び出し　  | 継承したコントラクトから呼び出し   | 外部から呼び出し  |
  |-------------|--------------------------|-------------------------------|----------------|
  | `public`    | ◯                        | ◯                             | ◯              |
  | `private`   | ◯                        | ✗                             | ✗              |
  | `internal`  | ◯                        | ◯                             | ✗              |
  | `external`  | ✗                        | ✗                             | ◯              |
  
  ※ 変数は`public`, `private`, `internal` のいずれか
  ※ 関数は`public`, `private`, `internal`, `external` のいずれか
 */

/*
  Data location: https://docs.soliditylang.org/en/v0.8.24/types.html#data-location-and-assignment-behavior

  | Data location  | Keyword | Meaning                                                                                   |
  |----------------|---------|-------------------------------------------------------------------------------------------|
  | storage        |         | Holds the variable in the blockchain. This is the most expensive mode, but it is also the most permanent. |
  | memory         | memory  | Holds the variable in memory. This is cheaper than storage, but it is temporary.         |
  | stack          |         | Holds the variable in the stack. This is the cheapest mode, but it is also the most limited. | 
  | calldata       | calldata| Holds the function arguments in the call data. This is a non-modifiable, non-persistent area where function arguments are stored, and behaves mostly like memory. |

  - `storage`: ブロックチェーン上の永続的な記憶領域。コストが高いが、データは関数が終了しても保持。
  - `memory`: 関数内で一時的にデータを保存する場所。関数が終了するとデータは消えるが、処理中は読み書きが可能。
  - `stack`: 非常に高速で低コストな一時的なデータ格納場所。データサイズに制限があり、短命なデータ向け。
  - `calldata`: 関数の引数が格納される読み取り専用の領域。書き込みや変更はできませんが、コストは低い。
  */

/*
  Function Types: https://docs.soliditylang.org/en/latest/types.html#function-types

  function (<parameter types>) {internal|external} [pure|view|payable] [returns (<return types>)]

  | Keyword | Meaning                                                                                   |
  |---------|-------------------------------------------------------------------------------------------|
  | pure    | Function does not read from or modify the state. It cannot modify the state.              |
  | view    | Function does not modify the state. It can read the state.                                |
  | payable | Function can receive Ether.                                                               |

  - `pure`: ブロックチェーンの状態を読み取ったり、変更したりすることはできない。純粋に計算処理のみを行う関数で使用。
  - `view`: ブロックチェーンの状態を「読み取る」ことはできるが、変更はできない。ストレージ内の値を参照する関数で使用。
  - `payable`: ブロックチェーンの状態を変更することができ、関数がETHを受け取れるようにする。
  */

contract Gachapon {
  // ガチャポンの名前
  string public gachaName;
  // ガチャポンの管理人
  address public owner;
  // ガチャのアイテムリスト
  string[] public items;
  // ユーザーごとの所有アイテムリスト
  mapping(address => string[]) public collection;

  constructor(string memory _name) {
    owner = msg.sender;
    gachaName = _name;
  }

  // ガチャの景品を補充する関数
  function addItems(string[] calldata _items) public {
    require(msg.sender == owner, 'You are not the owner.');

    for (uint i = 0; i < _items.length; i++) {
      items.push(_items[i]);
    }
  }

  // ガチャを回す関数
  function play() public {
    require(items.length > 0, 'No items available.');

    // ランダムなindexを生成する
    uint randomIndex = _random() % items.length;

    // 該当する景品を配列から取得し、ユーザーの所有アイテムリストに追加する
    string memory outputItem = items[randomIndex];
    collection[msg.sender].push(outputItem);

    // 獲得された景品をガチャから取り除くaire
    _removeItem(randomIndex);
  }

  // 乱数を生成する関数
  function _random() private view returns (uint) {
    return uint(keccak256(abi.encodePacked(block.timestamp, block.prevrandao, msg.sender)));
  }

  /**
    獲得された景品をガチャから取り除く関数

    削除の流れ: [1,2,3,4,5] -> [1,5,3,4,5] -> [1,5,3,4]
   */
  function _removeItem(uint _index) private {
    require(_index < items.length, 'Index out of bounds.');

    // 削除するindexに、配列の最後の要素を移動
    items[_index] = items[items.length - 1];

    // pop()を使って、配列の最後の要素を削除
    items.pop();
  }

  // 獲得した景品を確認する関数
  function getOwnedCollection(address _address) public view returns (string[] memory) {
    return collection[_address];
  }
}
