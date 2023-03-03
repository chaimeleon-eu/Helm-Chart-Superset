FROM apache/superset:1.5.3
# Switching to root to install the required packages
USER root
RUN pip install --no-cache-dir Authlib sqlalchemy-trino psycopg2 cx_Oracle pystan==2.19.1.1 prophet holidays==0.10.3
COPY superset/pythonpath /app/pythonpath

# Switching back to using the `superset` user
USER superset

ENTRYPOINT ["/bin/sh","-c","/usr/bin/run-server.sh"]

CMD ["superset","fab","create-admin","--username","admin","--password","admin","--firstname","Superset","--lastname","Admin","--email","superset@localdomain"]
CMD ["superset","db","upgrade"]
CMD ["superset","init"]
