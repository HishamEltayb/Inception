#!/bin/sh

openrc

rc-service mariadb setup
rc-service mariadb start

DB_PASSWORD=$(cat /run/secrets/DB_PASSWORD)
DB_ROOT_PASSWORD=$(cat /run/secrets/DB_ROOT_PASSWORD)

mysql -u $DB_ROOT_USER -e "ALTER USER '$DB_ROOT_USER'@'%' IDENTIFIED BY '$DB_ROOT_PASSWORD';"
mysql -u $DB_ROOT_USER -p$DB_ROOT_PASSWORD -e "CREATE DATABASE IF NOT EXISTS $DB_NAME;"
mysql -u $DB_ROOT_USER -p$DB_ROOT_PASSWORD -e "CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';"
mysql -u $DB_ROOT_USER -p$DB_ROOT_PASSWORD -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%' WITH GRANT OPTION;"
mysql -u $DB_ROOT_USER -p$DB_ROOT_PASSWORD -e "FLUSH PRIVILEGES;"


rc-service mariadb stop

# DB_PASSWORD=
# DB_ROOT_PASSWORD=

/usr/bin/mariadbd --basedir=$MARIADB_BASE_DIR   --datadir=$MARIADB_DATABASE_DIR --plugin-dir=$MARIADB_PLUGIN_DIR --user=$MARIADB_USER --pid-file=$MARIADB_PID_FILE

