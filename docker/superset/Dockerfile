FROM apache/superset:1.5.3
# Switching to root to install the required packages
USER root
RUN pip install --no-cache-dir Authlib sqlalchemy-trino psycopg2 cx_Oracle pystan==2.19.1.1 prophet holidays==0.10.3
COPY pythonpath /app/pythonpath
COPY initialize-superset.sh /app/initialize-superset.sh

# Switching back to using the `superset` user
USER superset

CMD ["/bin/sh", "-c", "(sh /app/initialize-superset.sh > /tmp/initialize-superset.out 2>&1 &); /usr/bin/run-server.sh"]

