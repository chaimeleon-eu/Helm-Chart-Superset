# Build and publish Docker image (TEST)
```
aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws/e6k1b4j9
docker build -t chaimeleon/superset .
docker tag chaimeleon/superset:latest public.ecr.aws/e6k1b4j9/chaimeleon/superset:latest
docker push public.ecr.aws/e6k1b4j9/chaimeleon/superset:latest
```

# Build and publish Docker image (CHAIMELEON)
```
docker login -u <user> -p <CLI secret> https://chaimeleon-eu.i3m.upv.es:10443
# El CLI secret se obtiene en Harbor > Perfil de usuario
# Para conectar a Harbor es neceario estar en la VPN de la UPV

docker build -t bahia-software/superset .
docker tag bahia-software/superset chaimeleon-eu.i3m.upv.es:10443/chaimeleon-library/bahia-software/superset:latest
docker push chaimeleon-eu.i3m.upv.es:10443/chaimeleon-library/bahia-software/superset:latest
```