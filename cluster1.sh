kubectx aws-workload1-admin@aws-workload1
kubectl apply -f gateway.yaml
kubectl apply -f todos-redis/app.yml
kubectl apply -f todos-api/app.yml
kubectl apply -f todos-edge/app.yml
kubectl apply -f todos-webui/app.yml