kubectl delete secret wavefront
kubectl delete -f service-account.yaml
kubectl delete -f todos-postgres/app.yml
kubectl delete -f todos-redis/app.yml
kubectl delete -f todos-api/app.yml
kubectl delete -f todos-webui/app.yml
kubectl delete -f todos-edge/app.yml
#helm del my-postgres
#helm del todo-redis-instance
#kubectl delete pvc data-my-postgres-mariadb-master-0
#kubectl delete pvc data-my-postgres-mariadb-slave-0
#kubectl delete pvc redis-data-todo-redis-instance-master-0
#kubectl delete pvc redis-data-todo-redis-instance-slave-0
#kubectl delete pvc redis-data-todo-redis-instance-slave-1