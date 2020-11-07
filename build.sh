export HARBOR=registry.private.tanzu.zwickey.net/library

mvn clean install -DskipTests
docker build -t azwickey/todos-edge todos-edge/
docker tag azwickey/todos-edge $HARBOR/todos-edge:latest
docker push $HARBOR/todos-edge:latest

docker build -t azwickey/todos-webui todos-webui/
docker tag azwickey/todos-webui $HARBOR/todos-webui:latest
docker push $HARBOR/todos-webui:latest

docker build -t azwickey/todos-api todos-api/
docker tag azwickey/todos-api $HARBOR/todos-api:latest
docker push $HARBOR/todos-api:latest

docker build -t azwickey/todos-redis todos-redis/
docker tag azwickey/todos-redis $HARBOR/todos-redis:latest
docker push $HARBOR/todos-redis:latest

docker build -t azwickey/todos-postgres todos-postgres/
docker tag azwickey/todos-postgres $HARBOR/todos-postgres:latest
docker push $HARBOR/todos-postgres:latest