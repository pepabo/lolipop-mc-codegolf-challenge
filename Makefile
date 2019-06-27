# ロリポップ！マネージドクラウド
SSH_HOST = ssh-1.mc.lolipop.jp # 変更してください
SSH_PORT = 10022 # 変更してください
SSH_USER = sshuser # 変更してください
DB_NAME = dbname # 変更してください
DB_USER = dbuser # 変更してください
DB_PASS = dbpass # 変更してください
DB_HOST = mysql-1.mc.lolipop.lan # 変更してください
DB_PORT = 3306

PROMPT_SSH_HOST ?= $(shell bash -c 'read -p "SSH / SFTP ホスト名(${SSH_HOST}): " VAL; echo $${VAL:-${SSH_HOST}}')
PROMPT_SSH_PORT ?= $(shell bash -c 'read -p "SSH / SFTP ポート(${SSH_PORT}): " VAL; echo $${VAL:-${SSH_PORT}}')
PROMPT_SSH_USER ?= $(shell bash -c 'read -p "SSH / SFTP ユーザー名(${SSH_USER}): " VAL; echo $${VAL:-${SSH_USER}}')
PROMPT_DB_NAME  ?= $(shell bash -c 'read -p "データベース データベース名(${DB_NAME}): " VAL; echo $${VAL:-${DB_NAME}}')
PROMPT_DB_USER  ?= $(shell bash -c 'read -p "データベース ユーザー名(${DB_USER}): " VAL; echo $${VAL:-${DB_USER}}')
PROMPT_DB_PASS  ?= $(shell bash -c 'read -s -p "データベース パスワード(${DB_PASS}): " VAL; echo $${VAL:-${DB_PASS}}')
PROMPT_DB_HOST  ?= $(shell bash -c 'read -p "データベース データベースのホスト名(${DB_HOST}): " VAL; echo $${VAL:-${DB_HOST}}')

default: check

deploy:
	$(eval SSH_PORT=${PROMPT_SSH_PORT})
	$(eval SSH_USER=${PROMPT_SSH_USER})
	$(eval SSH_HOST=${PROMPT_SSH_HOST})
	rsync -av -e "ssh -p ${SSH_PORT}" --delete ./ ${SSH_USER}@${SSH_HOST}:/var/www/html
	ssh -p ${SSH_PORT} ${SSH_USER}@${SSH_HOST} 'chmod -R 755 /var/www/html/'

install: install_composer
	php composer.phar install
	echo DB_NAME=${DB_NAME} > ./.env
	echo DB_USER=${DB_USER} >> ./.env
	echo DB_PASS=${DB_PASS} >> ./.env
	echo DB_HOST=${DB_HOST} >> ./.env
	echo DB_PORT=${DB_PORT} >> ./.env
	php composer.phar dump-autoload --optimize
	sqlite3 tokens.sqlite3 < initdb_sqlite.sql

server:
	php -S localhost:8000

install_composer:
	php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
	php -r "if (hash_file('sha384', 'composer-setup.php') === '48e3236262b34d30969dca3c37281b3b4bbe3221bda826ac6a9a62d6444cdb0dcd0615698a5cbe587c3f0fe57a54d8f5') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
	php composer-setup.php
	php -r "unlink('composer-setup.php');"

initdb:
	$(eval SSH_PORT=${PROMPT_SSH_PORT})
	$(eval SSH_USER=${PROMPT_SSH_USER})
	$(eval SSH_HOST=${PROMPT_SSH_HOST})
	$(eval DB_NAME=${PROMPT_DB_NAME})
	$(eval DB_USER=${PROMPT_DB_USER})
	$(eval DB_PASS=${PROMPT_DB_PASS})
	$(eval DB_HOST=${PROMPT_DB_HOST})
	scp -P ${SSH_PORT} ./initdb_mysql.sql ${SSH_USER}@${SSH_HOST}:/tmp/initdb.sql
	ssh -p ${SSH_PORT} ${SSH_USER}@${SSH_HOST} 'MYSQL_PWD=${DB_PASS} mysql --host=${DB_HOST} --user=${DB_USER} -D ${DB_NAME} < /tmp/initdb.sql'

check:
	$(eval SSH_PORT=${PROMPT_SSH_PORT})
	$(eval SSH_USER=${PROMPT_SSH_USER})
	$(eval SSH_HOST=${PROMPT_SSH_HOST})
	@ssh -p ${SSH_PORT} ${SSH_USER}@${SSH_HOST} 'find /var/www/html -type f -not -iwholename "*/.git/*" -not -name "Makefile" -not -name ".env" | cat | wc -c'

ssh:
	$(eval SSH_PORT=${PROMPT_SSH_PORT})
	$(eval SSH_USER=${PROMPT_SSH_USER})
	$(eval SSH_HOST=${PROMPT_SSH_HOST})
	ssh -p ${SSH_PORT} ${SSH_USER}@${SSH_HOST}
