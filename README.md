# daikou-app
代行車を依頼することができるwebアプリ

# 環境
- Ruby 3.0.3
- Rails 6.1.5

# 開発環境の初期設定
## 前提条件
- dockerが使用できる状態にあること

## 1.リポジトリのクローン
ご自身のPCの任意のディレクトリに、このリポジトリをクローンしてください。

## 2.master.keyの作成
※ 今回のアプリではmaster.keyを作成しなくても大丈夫です
configディレクトリにmaster.keyファイルを作成してください。既にファイルが存在している場合は、記載されている文字列を削除してください。
その後、アプリ管理者に指定された文字列をmaster.keyファイルに記入してください。

## 3.サービスのビルド
クローンしたアプリのディレクトリで、以下のコマンドを実行します。
```
make first-build
```

## 4.コンテナの起動
以下のコマンドを実行します。
```
make up
または
make up-d
```

# 動作確認
まずはコンテナを起動した状態でlocalhost:3520へアクセスしてください。
## ユーザーの登録
開発環境の初期設定で`make first-build`を行なった場合、既に動作確認用のユーザーが登録されています。
画面上部のリンクからログイン画面へ遷移し、下記の情報を入力することでログインが可能です。
```
email: sample@example.com
password: pass1234
```
ユーザーの新規登録も可能です。

## 新規代行依頼
ログイン後は新しく代行を依頼することができます。
画面上部の「代行依頼をする」をクリックし、必要な情報を入力してください。

## マイページ
ログイン後はマイページを利用することができます。
マイページでは以下の操作が行えます。
- プロフィールの編集：代行依頼時に必要な個人情報を編集することができます。
- 依頼一覧の確認：過去の代行依頼を一覧で確認することができます。
- 依頼のキャンセル：まだ完了していない依頼に限りキャンセルが可能です。

# makeコマンド
makeコマンドの一覧はMakefileを確認、または`make help`コマンドを実行してください。
