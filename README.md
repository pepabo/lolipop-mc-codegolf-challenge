![img](mc.png)

# Webページコードゴルフ

## 必要なもの

- PHP 7.3.2 ( PHP7以上であれば問題ないと思います )
- ssh
- rsync
- SQLite3

## レギュレーション

- あるPHPで構築されたWebサイトの、**表示を一切変えずに** Webサイトを構成する全コード全ファイルの合計ファイルサイズを小さくしてください
    - 最も小さいファイルサイズになった人が優勝です
- マネクラの `PHPプロジェクト` を利用してください
- コンテナ内の `/var/www/html` 内に全てのコード、およびファイルを設置してください
- Makefile内の `check` タスク内のコマンドの変更は禁止です

## はじめかた

1. このリポジトリを `git clone` します
2. MakefileでSSHポートやデータベースユーザの環境変数を書き換えます
3. ローカルで以下のコマンドを実行します
    - `make install`
4. `make server` を実行し、ブラウザで http://localhost:8000 で "マネクラからの挑戦状" の表示があれば開発環境の構築完了です。

## スコアチェック手順

1. `make deploy` を実行し、手元のソースコードをデプロイします
2. マネクラダッシュボードの `プロジェクトURL` にアクセスして "マネクラからの挑戦状" の表示があればデプロイ設置完了です。
3. https://phpconfuk-codegolf.lolipop.io/ にアクセスします
4. テキストフィールドにあなたのプロジェクトの `プロジェクトURL` を入力して `Show Diff` をクリックします
5. `Great!!! There is no difference !!!` と表示されたら **表示を一切変更していない** ことが認められました！
    - `Oh... There is a difference` と表示されたら失敗です。差分を確認して、修正して、再度挑戦してください。
6. このとき `make check` を実行してください。出てきた数字が現在のあなたのスコアです。小さければ小さいほど良いです。
7. スタッフに3のページと4の結果を見せてください。これでスコアが正式に認められました。

## ヒント

- [SFTP での接続方法](https://mclolipop.zendesk.com/hc/ja/articles/360001603267-SFTP-%E3%81%A7%E3%81%AE%E6%8E%A5%E7%B6%9A%E6%96%B9%E6%B3%95-Cyberduck-)
- [アプリケーションのログやアクセスログの確認方法](https://mclolipop.zendesk.com/hc/ja/articles/360022532394-%E3%82%A2%E3%83%97%E3%83%AA%E3%82%B1%E3%83%BC%E3%82%B7%E3%83%A7%E3%83%B3%E3%81%AE%E3%83%AD%E3%82%B0%E3%82%84%E3%82%A2%E3%82%AF%E3%82%BB%E3%82%B9%E3%83%AD%E3%82%B0%E3%81%AE%E7%A2%BA%E8%AA%8D%E6%96%B9%E6%B3%95)
- [クライアントツールを使用してデータベースにアクセスする (Sequel Proの場合)
](https://mclolipop.zendesk.com/hc/ja/articles/360001535547-%E3%82%AF%E3%83%A9%E3%82%A4%E3%82%A2%E3%83%B3%E3%83%88%E3%83%84%E3%83%BC%E3%83%AB%E3%82%92%E4%BD%BF%E7%94%A8%E3%81%97%E3%81%A6%E3%83%87%E3%83%BC%E3%82%BF%E3%83%99%E3%83%BC%E3%82%B9%E3%81%AB%E3%82%A2%E3%82%AF%E3%82%BB%E3%82%B9%E3%81%99%E3%82%8B-Sequel-Pro%E3%81%AE%E5%A0%B4%E5%90%88-)
