# db_daily_backup

This script is use for daily backup for mysql db.

-----------
How to use
-----------

###　1. set config file ###
* Copy config file from sample and edit it for your enviroment

~~~~
$ cp setting.conf.sample setting.conf
$ vi setting.conf
~~~~


### 2. cron setting ####
* Add cron setting

~~~~
echo "0 4 * * * root /dir_path/db_daily_backup/backup.sh" > /etc/cron.d/backupmysql
~~~~


------
Notice
------
* You shoud set MySQL binary log setting

~~~~
vim /etc/my.cnf


[mysqld]
log-bin=mysql-bin
expire_logs_days=3
~~~~

* You shoud send backup files to the other servers for this server failure
