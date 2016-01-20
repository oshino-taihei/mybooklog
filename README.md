# ブクログコピーアプリ

Rails学習を目的として、web本棚サービスのブクログの仕様をコピーして作ったアプリケーション

## URL

Heroku上にデプロイしたアプリケーションのURL

https://mybooklog.herokuapp.com

## 実装した仕様

実装した仕様と機能を実装したページを以下に示す。

* 「登録」より、ユーザ/パスワード情報を設定し、ユーザアカウントを作成できる
* 「ログイン」より、登録したユーザアカウント情報を入力し、認証・ログインできる
* 「ログアウト」より、ログアウトできる
* 「HOME」の「読書状況」にて、自分の本棚に登録済みの本の読書状況ごとのサマリが表示される
* 「HOME」の「友達のタイムライン」にて、フォローした人が最近登録した本の新着リストが表示される
* 「プロフィール」より、ユーザ情報を編集できる
* 「ユーザを探す」より、別ユーザの本棚をフォロー/アンフォローできる
* 「本を探す」より、本を検索し、自分の本棚に登録できる
* 「本棚」より、自分の本棚に登録された本を一覧表示できる
* 「本棚」の本のレビュー情報（読書状況、評価、カテゴリ、レビュー、タグ）を編集できる
* 「本棚」から本の絞り込みができる（読書状況、評価、カテゴリ、タグ、キーワード）
* 「カテゴリー設定」にて、ユーザごとにカテゴリー項目を指定できる

## セットアップ

本の検索にAmazon Product Advertising APIを使用しているため、アクセスキー情報を登録する必要がある。
アクセスキー情報は以下の環境変数から取得している。

$RAILS_ROOT/.env
````
AWS_ACCESS_KEY_ID="アクセスキーID"
AWS_SECRET_ACCESS_KEY="シークレットアクセスキー"
AWS_ASSOCIATE_TAG="アソシエイトID"
````
