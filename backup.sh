#!/bin/sh
# daily_backup/backup.sh

# this script file path
SCRIPT_DIRPATH=$(cd $(dirname $0);pwd)

# load setting file
. ${SCRIPT_DIRPATH}/setting.conf

# backup dir name in this SCRIPT_DIRPATH
BACKUP_DIRNAME="data"

FILENAME_PREFIX=`date +%Y%m%d`
FILENAME_PREFIX_OLD=`date --date "$BACKUP_PERIOD days ago" +%Y%m%d`

i=0
for db in ${DB_LIST[@]}; do
  BACKUP_FILEPATH="${SCRIPT_DIRPATH}/${BACKUP_DIRNAME}/${FILENAME_PREFIX}_${db}.sql"

  # execute backup
  /usr/bin/mysqldump --defaults-file=$MYSQLCONF_FILEPATH $DUMP_OPTION $db > $BACKUP_FILEPATH
  chmod 700 $BACKUP_FILEPATH

  # remove old backup
  BACKUP_FILEPATH_OLD="${SCRIPT_DIRPATH}/${BACKUP_DIRNAME}/${FILENAME_PREFIX_OLD}_${db}.sql"
  if [ -f $BACKUP_FILEPATH_OLD ]
  then
    rm -f $BACKUP_FILEPATH_OLD
  fi

  let i++
done

