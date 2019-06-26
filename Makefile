DB_NAME  ?= "プロジェクトダッシュボードの 'データベース名' に書き換えてください"
DB_USER  ?= "プロジェクトダッシュボードの 'ユーザー名' に書き換えてください"
DB_PASS  ?= "プロジェクトダッシュボードの 'パスワード' に書き換えてください"
DB_HOST  ?= mysql-1.mc.lolipop.lan
DB_PORT  ?= 3306

default: check

setup: install_composer initdb
	php composer.phar install
	echo DB_NAME=${DB_NAME} > ./.env
	echo DB_USER=${DB_USER} >> ./.env
	echo DB_PASS=${DB_PASS} >> ./.env
	echo DB_HOST=${DB_HOST} >> ./.env
	echo DB_PORT=${DB_PORT} >> ./.env

install_composer:
	php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
	php -r "if (hash_file('sha384', 'composer-setup.php') === '48e3236262b34d30969dca3c37281b3b4bbe3221bda826ac6a9a62d6444cdb0dcd0615698a5cbe587c3f0fe57a54d8f5') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
	php composer-setup.php
	php -r "unlink('composer-setup.php');"

initdb:
	MYSQL_PWD=${DB_PASS} mysql --host=${DB_HOST} --user=${DB_USER} --port=${DB_PORT} -D ${DB_NAME} < initdb.sql

check:
	@find . -type f -not -iwholename '*/.git/*' -not -name 'Makefile' -not -name '.env' | cat | wc --bytes
