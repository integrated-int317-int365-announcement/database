FROM mysql:8
COPY ./sql-script ./script
COPY ./sql-script/ /docker-entrypoint-initdb.d/script
# RUN --mount=type=secret,id=test_secret \
#   cat /run/secrets/test_secret 
EXPOSE 3306:3306
