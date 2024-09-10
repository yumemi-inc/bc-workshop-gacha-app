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

    // 該当する景品をアイテムリストの配列から取得し、ユーザーの所有アイテムリストに追加する
    string memory outputItem = items[randomIndex];
    collection[msg.sender].push(outputItem);

    // 獲得された景品をアイテムリストから取り除く
    _removeItem(randomIndex);
  }

  // 乱数を生成する関数
  function _random() private view returns (uint) {
    return uint(keccak256(abi.encodePacked(block.timestamp, block.prevrandao, msg.sender)));
  }

  // 獲得された景品をアイテムリストから取り除く関数
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
