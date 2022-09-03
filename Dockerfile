FROM mysql:8
# COPY ./sql-script ./script
COPY ./sql-script/ /docker-entrypoint-initdb.d/
RUN --mount=type=secret,id=test_secret \
  cat /run/secrets/test_secret 
RUN touch test-secret \ cat /run/secrets/test_secret > test-secret
COPY ./test-secret ./
# RUN --mount=type=secret,id=test_secret \
#   cat /run/secrets/test_secret 
EXPOSE 3306:3306
