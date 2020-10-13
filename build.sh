mvn clean install -DskipTests
docker build -t azwickey/todos-edge todos-edge/
docker tag azwickey/todos-edge harbor.mgmt.tanzu.zwickey.net/library/todos-edge:latest
docker push harbor.mgmt.tanzu.zwickey.net/library/todos-edge:latest

docker build -t azwickey/todos-webui todos-webui/
docker tag azwickey/todos-webui harbor.mgmt.tanzu.zwickey.net/library/todos-webui:latest
docker push harbor.mgmt.tanzu.zwickey.net/library/todos-webui:latest

docker build -t azwickey/todos-api todos-api/
docker tag azwickey/todos-api harbor.mgmt.tanzu.zwickey.net/library/todos-api:latest
docker push harbor.mgmt.tanzu.zwickey.net/library/todos-api:latest

docker build -t azwickey/todos-redis todos-redis/
docker tag azwickey/todos-redis harbor.mgmt.tanzu.zwickey.net/library/todos-redis:latest
docker push harbor.mgmt.tanzu.zwickey.net/library/todos-redis:latest

docker build -t azwickey/todos-postgres todos-postgres/
docker tag azwickey/todos-postgres harbor.mgmt.tanzu.zwickey.net/library/todos-postgres:latest
docker push harbor.mgmt.tanzu.zwickey.net/library/todos-postgres:latest