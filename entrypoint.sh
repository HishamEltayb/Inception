#!/bin/sh


rc-service mariadb setup
rc-service mariadb start


DB_PASSWORD=$(cat /run/secrets/DB_PASSWORD)
DB_ROOT_PASSWORD=$(cat /run/secrets/DB_ROOT_PASSWORD)


mysql -u $DB_ROOT_USER -e "CREATE DATABASE IF NOT EXISTS $DB_NAME;"
# Create local user
mysql -u $DB_ROOT_USER -e "CREATE USER IF NOT EXISTS '$DB_USER'@'localhost' IDENTIFIED BY '$DB_PASSWORD';"
mysql -u $DB_ROOT_USER -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'localhost' WITH GRANT OPTION;"
# Create remote access user (with '%' wildcard for any host)
mysql -u $DB_ROOT_USER -e "CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';"
mysql -u $DB_ROOT_USER -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%' WITH GRANT OPTION;"
mysql -u $DB_ROOT_USER -e "FLUSH PRIVILEGES;"
mysql -u $DB_ROOT_USER -e "ALTER USER '$DB_ROOT_USER'@'localhost' IDENTIFIED BY '$DB_ROOT_PASSWORD';"


DB_PASSWORD=
DB_ROOT_PASSWORD=

/bin/sh
