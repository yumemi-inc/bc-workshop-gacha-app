## 第二回 【エンジニア向け】 ブロックチェーンワークショップ

### 開発環境について

- Node.js (v20.9.0)
- Yarn (v3.8.5)

### ローカル環境セットアップ

1. 開発環境のセットアップ

```
corepack enable
```

2. 依存関係のインストール

```
yarn install
```

3. env ファイルの準備

```
cd packages/contract/
cp .env.example .env.local
```

4. 以下の情報を `.env.local` に設定
   - アカウントの秘密鍵
   - [Etherscan API](https://etherscan.io/apis) の利用登録を行い、取得した API Key

### フォルダー構造について

```
.
├── packgages/
│   ├── client/ # フロント開発環境
│   │   └── package.json
│   └── contract/ # スマートコントラクト開発環境
│       └── package.json
└── package.json
```
