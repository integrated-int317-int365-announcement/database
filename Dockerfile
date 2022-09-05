FROM mysql:8
COPY ./sql-script ./script
# COPY ./entrypoint.sh /docker-entrypoint-initdb.d/
ADD ./sql-script/create-annms-schema_1.3.19.sql /docker-entrypoint-initdb.d/
# RUN --mount=type=secret,id=test_secret \
#   cat /run/secrets/test_secret 
EXPOSE 3306:3306
