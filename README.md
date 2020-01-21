<div align="center">
  <br>
  <a target="_blank" rel="noopener noreferrer" href="https://www.dotwiki.xyz"><img alt="DEV" src="https://user-images.githubusercontent.com/6788936/72482956-b8581a00-3842-11ea-963b-baef441e2a9b.png" width="300px" style="max-width:100%;"></a>
</div>

# dotwiki

Next-generation wiki service that allows you to write in markdown, manage maintainers, make edit requests, and identify contributors.

## Require

- ruby
- node.js(webpack)
- vue.js
- postgresql
- overmind(`brew install overmind`)

## Setup

```
$ bin/setup
```

## Development

```
$ npm run rails

# or

$ rails s
$ npm run wds
```

## メイン機能ロードマップ

- [x] ユーザー認証
- [ ] Wikiの作成
  - [x] 基本的なCRUD
  - [ ] アップロードファイルの制限
- [x] ページの作成
  - [x] 編集履歴
  - [x] マークダウンエディタ(simpleMDE)
  - [x] 画像アップロード機能(cloudinary)
- [ ] Watch機能
  - [x] ひとまずブックマーク的な機能
  - [ ] 新着情報をホームで表示
- [x] 権限による編集制御
  - [ ] だいぶ雑に書いたのでリファクタリング
- [ ] 編集リクエスト機能
  - [x] 行差分をどう扱うか決める(sample: diff_snippet.rb)
- [ ] 通知機能
- [ ] コメント機能
- [ ] ブログ機能
- [ ] 貢献度可視化システム
  - [ ] メンテナー選出システム
- [ ] お問い合わせ機能
- [ ] 感情分析機能
- [ ] プライベートwikiの作成
- [ ] プライベートコメント機能
- [ ] 画像のアップロード制限解除
- [x] 高速化(instant.page導入)
- [ ] AMP対応

