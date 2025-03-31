#!/bin/sh

if [ ! -d "${MARIADB_DATABASE_DIR}/mysql" ]; then
    openrc

    rc-service mariadb setup
    rc-service mariadb start
    

    
    DB_PASSWORD=$(cat /run/secrets/DB_PASSWORD)
    DB_ROOT_PASSWORD=$(cat /run/secrets/DB_ROOT_PASSWORD)
    
    mysql -u $DB_ROOT_USER -e "
    CREATE DATABASE IF NOT EXISTS $DB_NAME;
    CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';
    GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%' WITH GRANT OPTION;
    FLUSH PRIVILEGES;
    ALTER USER '$DB_ROOT_USER'@'%' IDENTIFIED BY '$DB_ROOT_PASSWORD';"
    
    mysqladmin -u root shutdown
fi

/usr/bin/mariadbd --user=$MARIADB_USER \
    --datadir=$MARIADB_DATABASE_DIR \
    --plugin-dir=$MARIADB_PLUGIN_DIR \
    --pid-file=$MARIADB_PID_FILE
