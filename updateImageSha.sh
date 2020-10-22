set -x

# Cluster 1
yq write todos-chart/cluster1/values.yaml -i "apiSha" \
  $(kubectl get images.kpack.io todos-api -o json | jq '.status.latestImage' | cut -d '@' -f 2 | tr -d '"')
yq write todos-chart/cluster1/values.yaml -i "edgeSha" \
  $(kubectl get images.kpack.io todos-edge -o json | jq '.status.latestImage' | cut -d '@' -f 2 | tr -d '"')
yq write todos-chart/cluster1/values.yaml -i "redisSha" \
  $(kubectl get images.kpack.io todos-redis -o json | jq '.status.latestImage' | cut -d '@' -f 2 | tr -d '"')
yq write todos-chart/cluster1/values.yaml -i "webuiSha" \
  $(kubectl get images.kpack.io todos-webui -o json | jq '.status.latestImage' | cut -d '@' -f 2 | tr -d '"')

# Cluster 2
yq write todos-chart/cluster2/values.yaml -i "postgresSha" \
  $(kubectl get images.kpack.io todos-postgres -o json | jq '.status.latestImage' | cut -d '@' -f 2 | tr -d '"')

git add todos-chart/cluster1/values.yaml
git add todos-chart/cluster2/values.yaml
git commit -m "bumping image shas"
git push