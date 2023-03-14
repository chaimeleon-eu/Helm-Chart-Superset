until curl -f http://localhost:8088/health; do 
  echo waiting for superset...
  sleep 8
done
superset fab create-admin --username admin --password admin --firstname Superset --lastname Admin --email superset@localdomain
superset db upgrade
superset init
