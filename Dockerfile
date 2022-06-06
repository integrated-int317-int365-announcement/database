FROM mysql:8
COPY ./sql-script ./script
EXPOSE 3306:3306
