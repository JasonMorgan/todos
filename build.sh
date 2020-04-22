mvn clean install -DskipTests
docker build -t dpfeffer/todos-edge todos-edge/
docker tag dpfeffer/todos-edge harbor.lab.winterfell.live/workshop-alana/todos-edge:latest
docker push harbor.lab.winterfell.live/workshop-alana/todos-edge:latest

docker build -t dpfeffer/todos-webui todos-webui/
docker tag dpfeffer/todos-webui harbor.lab.winterfell.live/workshop-alana/todos-webui:latest
docker push harbor.lab.winterfell.live/workshop-alana/todos-webui:latest

docker build -t dpfeffer/todos-api todos-api/
docker tag dpfeffer/todos-api harbor.lab.winterfell.live/workshop-alana/todos-api:latest
docker push harbor.lab.winterfell.live/workshop-alana/todos-api:latest

docker build -t dpfeffer/todos-redis todos-redis/
docker tag dpfeffer/todos-redis harbor.lab.winterfell.live/workshop-alana/todos-redis:latest
docker push harbor.lab.winterfell.live/workshop-alana/todos-redis:latest

docker build -t dpfeffer/todos-postgres todos-postgres/
docker tag dpfeffer/todos-postgres harbor.lab.winterfell.live/workshop-alana/todos-postgres:latest
docker push harbor.lab.winterfell.live/workshop-alana/todos-postgres:latest