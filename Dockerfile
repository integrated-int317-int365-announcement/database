FROM mysql:8
# COPY ./sql-script ./script
COPY ./sql-scripts/ /docker-entrypoint-initdb.d/
EXPOSE 3306:3306
