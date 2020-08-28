# README
<img src="https://img.shields.io/badge/ruby-2.6.5-green.svg?longCache=true"> <img src="https://img.shields.io/badge/aws-EC2-yellow.svg?longCache=true"> <img src="https://img.shields.io/badge/aws-S3-yellow.svg?longCache=true"> <img src="https://img.shields.io/badge/mysql-14-blue.svg?longCache=true"> <img src="https://img.shields.io/badge/-jquery-green.svg?longCache=true"> 


## :octocat: fleamarket_80h :octocat:
 フリマアプリ【メルカリ】のクローンサイト。 誰でも簡単に売買が楽しめるフリマアプリ機能を再現しています。 ユーザー登録、出品、購入機能を再現しています。

## Link to our app
[フリマWEBサイトアプリケーション](http://54.92.4.10/)
 
 
 Basic認証(ID:user80/pass:userh80)

## Test User
* 購入者用アカウント
  * メールアドレス　buyer@item.com
  * パスワード　1111111
* 購入用カード情報
  * 番号：4242424242424242
  * 期限：01/29
  * セキュリティコード：123
* 出品用アカウント
  * メールアドレス seller@item.com
  * パスワード 1111111

## DEMO
- ER図 https://gyazo.com/507d7b01c8f60f185ab299245e5be38f
- トップページ https://gyazo.com/c080db75a43dffdb592f0854c55674b4
- マイページ一覧　https://gyazo.com/b2e01967c7e80e91ff1e9fd16cf798fc
- 出品購入画面 https://gyazo.com/14916211123281b194971853e46f7af8
- 商品詳細ページ https://gyazo.com/1b5a4d2025b6826f3a32eb803a028811
- 会員情報画面 https://gyazo.com/6ec359317b617df6f79730968de4a9db

## Features
- ユーザー登録機能　【gem:devise,jp_prefecture】【ウィザード形式】
- ユーザーログイン/ログアウト機能 【gem:devise】
- 商品購入機能　【gem:pay.jp】
- 商品出品機能 【gem:jquery,ancestry】
- 商品編集機能
- 商品削除機能　
- 商品詳細機能　【gem:ancestry】
- カテゴリー機能 【gem:ancestry】
- 商品検索機能
- パンくず機能 【gem:gretel】

## Installation
- $ git clone https://github.com/goemon11/fleamarket_sample_80h.git
- $ cd fleamarket_sample_80h.git
- $ bundle install

## Author
- Ryo Ishikawa(Roll of ScrumMaster)
- Mayuko Ueda
- Hideki Kato
- Ryoma Kida
- Sasuke Watanabe

## Person in charge of a task
* Ryo Ishikawa
  * スクラムマスター、ユーザー新規登録/ログインページ【フロントサイド】、パンくず【サーバーサイド】
  * 商品出品機能【サーバーサイド】、カテゴリー機能【サーバーサイド】、デプロイ担当、データベース設計
* Mayuko Ueda
  * 商品出品ページ【フロントサイド】、ユーザーマイページ【フロントサイド】、カテゴリー機能【サーバーサイド及フロントサイド】 
  * 検索機能【サーバーサイド】、商品詳細表示【サーバーサイド及フロントサイド】、データベース設計
* Hideki Kato
  * ユーザー新規登録/ログインページ【フロントサイド】、商品一覧表示【サーバーサイド】
  * README.md【編集】、リファクタリング【CSS】、データベース設計
* Ryoma Kida
  * 商品確認ページ【フロントサイド】、ユーザー新規登録/ログイン【サーバーサイド】、商品削除【フロントサイド及サーバーサイド】
  * 商品情報編集【フロントサイド及サーバーサイド】、データベース設計
* Sasuke Watanabe
  * トップページ【フロントサイド】、商品購入機能【フロントサイド及サーバーサイド】、ユーザー新規登録/ログイン【サーバーサイド及フロントサイド】
  * ユーザーマイページ【フロントサイド】、データベース設計

## itemsテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|description|text|null: false|
|price|integer|null: false|
|size|string|
|brand|string|
|prefecture_code|integer|null: false|
|category_id|references|foreign_key: true|
|status_id|references|foreign_key: true|
|order_id|references|foreign_key: true|
|user_id|references|foreign_key: true|
|delivery_responsibility_id|references|foreign_key: true|
|preparation_day_id|references|foreign_key: true|


### Association
- belongs_to :category
- belongs_to :status
- belongs_to :user
- belongs_to :delivery_responsibility
- belongs_to :preparation_day
- has_one :order, dependent: :destroy
- has_many :item_images, dependent: :destroy


## categoriesテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|ancestry|string|

### Association
- has_many :items


## item_imagesテーブル

|Column|Type|Options|
|------|----|-------|
|image|string|null: false|
|item_id|references|foreign_key: true|

### Association
- belongs_to :item

## statusesテーブル

|Column|Type|Options|
|------|----|-------|
|status|string|null: false|

### Association
- has_many :items


## preparation_daysテーブル

|Column|Type|Options|
|------|----|-------|
|preparation_days|string|null: false|

### Association
- has_many :items


## delivery_responsibilitiesテーブル

|Column|Type|Options|
|------|----|-------|
|responsibility|string|null: false|

### Association
- has_many :items

## ordersテーブル

|Column|Type|Options|
|------|----|-------|
|item_id|references|foreign_key: true|
|seller_id|references|foreign_key: { to_table: users }, null: false|
|buyer_id|references|foreign_key: { to_table: users }, null: false|

### Association
- belongs_to :item
- belongs_to :seller, class_name: 'User', foreign_key: 'seller_id'
- belongs_to :buyer, class_name: 'User', foreign_key: 'buyer_id'



## usersテーブル

|Column|Type|Options|
|------|----|-------|
|nick_name|string|null: false|
|email|string|null: false|
|image|string|
|password|string|null: false|
|password_confirmation|string|null: false|
|phone_number|integer|null: false, unique: true|

### Association
- has_one :profile
- has_one :delivery_destination
- has_one :credit_card
- has_many :orders
- has_many :sns_credentials
- has_many :items
- has_many :seller_orders, class_name: 'Order', foreign_key: 'seller_id'
- has_many :buyer_orders, class_name: 'Order', foreign_key: 'buyer_id'

## profilesテーブル

|Column|Type|Options|
|------|----|-------|
|family_name|string|null: false|
|first_name|string|null: false|
|family_name_kana|string|null: false|
|first_name_kana|string|null: false|
|birthday|date|null: false|
|introduction|text|
|user_id|references|foreign_key: true|

### Association
- belongs_to :user


## delivery_destinationsテーブル

|Column|Type|Options|
|------|----|-------|
|delivery_family_name|string|null: false|
|delivery_first_name|string|null: false|
|delivery_family_name_kana|string|null: false|
|delivery_first_name_kana|string|null: false|
|delivery_phone_number|integer|
|post_code|integer|null: false|
|prefecture_code|integer|null: false|
|city|integer|null: false|
|house_number|string|null: false|
|building_name|string|
|user_id|references|foreign_key: true|

### Association
- belongs_to :user


## credit_cardsテーブル

|Column|Type|Options|
|------|----|-------|
|customer_id|integer|null: false|
|card_id|integer|null: false|
|user_id|references|foreign_key: true|

### Association
- belongs_to :user


## sns_credentialsテーブル

|Column|Type|Options|
|------|----|-------|
|provider|string|
|uid|string|
|user_id|references|foreign_key: true|

### Association
- belongs_to :user