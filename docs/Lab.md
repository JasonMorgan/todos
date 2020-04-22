# Lab

## Customizations if you don't use helm

### Harbor Reference

1. Update the image reference to your harbor project app.yaml (5 files)
2. Update harbor reference build.sh (10 places)

### Ingress Reference

1. Update ingress url in each each project's app.yaml (5 files)

### Create Wavefront Secret

Create a secret for the wavefront info.

export WAVEFRONT_URI=https://longboard.wavefront.com
export WAVEFRONT_API_TOKEN=YOUR_TOKEN
export WAVEFRONT_APPLICATION_NAME= YOUR_NAME Todos Application

kubectl create secret generic wavefront \
  --from-literal management.metrics.export.wavefront.uri=$WAVEFRONT_URI \
  --from-literal management.metrics.export.wavefront.apiToken=$WAVEFRONT_API_TOKEN \
  --from-literal management.metrics.export.wavefront.application.name=$WAVEFRONT_APPLICATION_NAME
{{ .Values.imageRepository }}

## Helm Customizations

export WAVEFRONT_URI=https://longboard.wavefront.com
export WAVEFRONT_API_TOKEN=YOUR_TOKEN
export WAVEFRONT_APPLICATION_NAME=YOUR_NAME Todos Application
export IMAGE_REPOSITORY=harbor.lab.winterfell.live/workshop-alana
export INGRESS_URL=workshop.pks.lab.winterfell.live

helm install --dry-run --debug todos ./todos-chart \
    --set wavefront.apiToken=$WAVEFRONT_API_TOKEN \
    --set wavefront.uri=$WAVEFRONT_URI \
    --set wavefront.application.name="$WAVEFRONT_APPLICATION_NAME" \
    --set imageRepository=$IMAGE_REPOSITORY \
    --set ingressUrl=$INGRESS_URL
    
helm install todos ./todos-chart \
    --set wavefront.apiToken=$WAVEFRONT_API_TOKEN \
    --set wavefront.uri=$WAVEFRONT_URI \
    --set wavefront.application.name="$WAVEFRONT_APPLICATION_NAME" \
    --set imageRepository=$IMAGE_REPOSITORY \
    --set ingressUrl=$INGRESS_URL
    
helm upgrade todos ./todos-chart \
    --set wavefront.apiToken=$WAVEFRONT_API_TOKEN \
    --set wavefront.uri=$WAVEFRONT_URI \
    --set wavefront.application.name="$WAVEFRONT_APPLICATION_NAME" \
    --set imageRepository=$IMAGE_REPOSITORY \
    --set ingressUrl=$INGRESS_URL

helm delete todos
