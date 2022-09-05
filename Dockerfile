FROM mysql:8
ADD ./sql-script/create-annms-schema.sql /docker-entrypoint-initdb.d/
EXPOSE 3306:3306