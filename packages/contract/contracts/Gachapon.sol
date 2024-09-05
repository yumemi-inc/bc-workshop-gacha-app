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
  string[] private items;
  // ユーザーごとの所有アイテムリスト
  mapping(address => string[]) public collection;

  // ガチャの景品を補充する関数
  function addItems(string[] calldata _items) public {}

  // ガチャを回して景品を獲得する関数
  function play() public returns (string memory) {}

  // 乱数を生成する関数
  function _random() private view returns (uint) {
    return uint(keccak256(abi.encodePacked(block.timestamp, block.prevrandao, msg.sender)));
  }

  // 獲得された景品をガチャから取り除く関数
  function _removeItem(uint _index) private {}

  // 獲得した景品を確認する関数
  function getOwnedCollection() public view returns (string[] memory) {}
}
