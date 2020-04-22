#helm repo add bitnami https://charts.bitnami.com/bitnami
#helm install my-postgres bitnami/postgresql --set postgresqlPassword=topsecret --set service.type=LoadBalancer
#helm install todo-redis-instance bitnami/redis --set global.redis.password=topsecret
kubectl create secret generic wavefront \
  --from-literal management.metrics.export.wavefront.uri=$WAVEFRONT_URI \
  --from-literal management.metrics.export.wavefront.apiToken=$WAVEFRONT_API_TOKEN \
  --from-literal management.metrics.export.wavefront.application.name="$WAVEFRONT_APPLICATION_NAME"
kubectl label secret wavefront scope=todos-all
kubectl apply -f service-account.yaml
kubectl apply -f todos-postgres/app.yml
kubectl apply -f todos-redis/app.yml
kubectl apply -f todos-api/app.yml
kubectl apply -f todos-webui/app.yml
kubectl apply -f todos-edge/app.yml