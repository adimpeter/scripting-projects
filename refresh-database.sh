#!\bin\bash

DB_HOST=$(echo $DB_HOST)
DB_NAME=$(echo $DB_NAME)
DB_USER=$(echo $DB_USER)
DB_PASS=$(echo $DB_PASS)

DB_DUMP_DIR=/var/tmp
LOG_DIR=/var/tmp/db-refresh-log
LOG_FILE=db-refresh-cron.log


timestamp(){
	echo date '%(%Y-%m-%d)T'
}


mkdir -p ${LOG_DIR}
touch ${LOG_DIR}/${LOG_FILE}

mysqldump -h ${DB_HOST} -u ${DB_USER} -p ${DB_PASS} ${DB_NAME} > ${DB_DUMP_DIR}/refresh.sql

mysql -h ${DB_HOST} -u ${DB_USER} -p ${DB_PASS} < ${DB_DUMP_DIR}/refresh.sql

echo "$[timestamp]: running database reset" >> ${LOG_DIR}/${LOG_FILE}