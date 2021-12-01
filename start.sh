#!/bin/bash 

set -e

useradd mysql || true
mkdir -p /home/mysql && chown mysql:mysql /home/mysql

mysqld --initialize-insecure --user=mysql
mysql_ssl_rsa_setup --uid=mysql
echo -e '[mysqld]\nserver-id=1\nlog-bin=mysql\nbinlog-format=row\ngtid-mode=ON\nenforce_gtid_consistency=ON\n' > /etc/mysql/conf.d/replication.cnf

# start mysql server
echo "Starting MySQL server..."
service mysql start

# wait for mysql server to start (max 30 seconds)
timeout=30
while ! /usr/bin/mysqladmin -u root status >/dev/null 2>&1
do
  timeout=$(($timeout - 1))
  if [ $timeout -eq 0 ]; then
    echo "Could not connect to mysql server. Aborting..."
    exit 1
  fi
  echo "Waiting for database server to accept connections..."
  sleep 1
done

mysql -uroot -e "use mysql; update user set authentication_string=PASSWORD(''), host='%' where User='root'; update user set plugin='mysql_native_password'; FLUSH PRIVILEGES;"

mysql -e "CREATE DATABASE IF NOT EXISTS test;" -uroot
mysql -e "SHOW VARIABLES LIKE 'log_bin'" -uroot

# restart
/usr/bin/mysqladmin shutdown
/usr/bin/mysqld_safe
