# MyLife

***

## アプリケーションの概要
人生共有サイト

***

## アプリケーションの機能一覧
- 会員登録機能/ログイン機能（gem:deviseを使用）
- FacebookのAPIを利用した会員登録機能/ログイン機能
- 自分の歴史作成機能
- 各歴史に対してコメントする機能（非同期通信：Railsで書けるAjax）
- 各歴史をブックマークする機能（非同期通信：Railsで書けるAjax）
- 各歴史のグラフ表示機能（chart.jsの使用）
- ユーザー同士のDM機能（非同期通信：Railsで書けるAjax）
- アンケート作成機能
- アンケート投票機能（非同期通信：Jqueryで書くAjax+json）
- 複数条件あいまい検索機能（２種類の方法で検索可）
- タグ機能(gem:acts-as-taggable-on+jqueryライブラリ:bootstrap-tagsinputを使用)
- 画像投稿機能（RailsのActiveStorage＋AWSのS3を使用）
- ページネーション機能（gem:kaminariを使用）

***

## アプリケーション内で使用した技術
- インフラ
  - AWS（EC2、RDS、S３、ELB、ACM、Route53、IAM）
- データベース
  - MySQL
- サーバー
  - Apache + Passenger
- テスト
  - rspecのモデルテスト
  - rspecのシステムテスト（headlesschromeで実行）
- その他
  - gem:wheneverによるバッチ処理の実装
  - gem:bulletによる一部ページのSQLの効率化
  - gem:dotenv-railsによる環境変数管理
  - FacebookのAPI
  - SSL通信の実装
  - rbenvによるRubyのバージョン管理
  - CSSアニメーション
  - 自分のパソコン内でローカル開発するための環境構築
 
 ***
 
 ## セキュリティアラートへの対応
1. gem 'omniauth'  ->  gem 'omniauth-rails_csrf_protection'の導入＋HTTPメソッドをPOSTにすることで対応済み  
[参考ページ](https://github.com/omniauth/omniauth/wiki/Resolving-CVE-2015-9284)
2. gem 'loofah'  ->  `bundle update --conservative loofah`で対応済み（本番環境）
