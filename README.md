![img](mc.png)

# Webページコードゴルフ

## レギュレーション

- あるPHPで構築されたWebサイトの、**表示を一切変えずに** Webサイトを構成する全コード全ファイルの合計サイズを小さくしてください
- 最も小さい合計ファイルサイズになった人が優勝です
- マネクラの `PHPプロジェクト` を利用してください
- コンテナ内の `/var/www/html` 内に全てのコード、およびファイルを設置してください
- Makefile内の `check` タスク内のコマンドの変更は禁止です

## はじめかた

1. マネクラで新規PHPプロジェクトを作成します
2. SSHでコンテナにログインします
3. 以下のコマンドをコピーして実行します
    - `rm -rf $HOME/html; git clone https://github.com/pepabo/lolipop-mc-codegolf-phpconfuk-2019.git $HOME/html`
    - (Private リポジトリになっている場合、ペパボパートナーのみ) `rm -rf $HOME/html; git clone https://${GITHUB_USERNAME}:${GITHUB_TOKEN}@github.com/pepabo/lolipop-mc-codegolf-phpconfuk-2019.git $HOME/html`
4. `html/` ディレクトリ内のMakefileを修正して以下の環境変数をマネクラダッシュボードの情報を元に書き換えてください
    - DB_NAME
    - DB_USER
    - DB_PASS
5. `make setup` を実行してください
6. マネクラダッシュボードの `プロジェクトURL` にアクセスして "マネクラからの挑戦状" の表示があれば初期設置完了です。

## スコアチェック手順

1. https://phpconfuk-codegolf.lolipop.io/ にアクセスします
2. テキストフィールドにあなたのプロジェクトの `プロジェクトURL` を入力して `Show Diff` をクリックします
3. `Great!!! There is no difference !!!` と表示されたら **表示を一切変更していない** ことが認められました！
    - `Oh... There is a difference` と表示されたら失敗です。差分を確認して、修正して、再度挑戦してください。
4. このときSSHコンテナ内で `cd $HOME/html; make check` を実行してください。出てきた数字が現在のあなたのスコアです。小さければ小さいほど良いです。
5. スタッフに3のページと4の結果を見せてください。これでスコアが正式に認められました。

## ヒント

- [SFTP での接続方法](https://mclolipop.zendesk.com/hc/ja/articles/360001603267-SFTP-%E3%81%A7%E3%81%AE%E6%8E%A5%E7%B6%9A%E6%96%B9%E6%B3%95-Cyberduck-)
- [アプリケーションのログやアクセスログの確認方法](https://mclolipop.zendesk.com/hc/ja/articles/360022532394-%E3%82%A2%E3%83%97%E3%83%AA%E3%82%B1%E3%83%BC%E3%82%B7%E3%83%A7%E3%83%B3%E3%81%AE%E3%83%AD%E3%82%B0%E3%82%84%E3%82%A2%E3%82%AF%E3%82%BB%E3%82%B9%E3%83%AD%E3%82%B0%E3%81%AE%E7%A2%BA%E8%AA%8D%E6%96%B9%E6%B3%95)
- [クライアントツールを使用してデータベースにアクセスする (Sequel Proの場合)
](https://mclolipop.zendesk.com/hc/ja/articles/360001535547-%E3%82%AF%E3%83%A9%E3%82%A4%E3%82%A2%E3%83%B3%E3%83%88%E3%83%84%E3%83%BC%E3%83%AB%E3%82%92%E4%BD%BF%E7%94%A8%E3%81%97%E3%81%A6%E3%83%87%E3%83%BC%E3%82%BF%E3%83%99%E3%83%BC%E3%82%B9%E3%81%AB%E3%82%A2%E3%82%AF%E3%82%BB%E3%82%B9%E3%81%99%E3%82%8B-Sequel-Pro%E3%81%AE%E5%A0%B4%E5%90%88-)
