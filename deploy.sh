docker build -t jakubhav/multi-client-k8s:latest -t jakubhav/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t jakubhav/multi-server-k8s-pgfix:latest -t jakubhav/multi-server-k8s-pgfix:$SHA -f ./server/Dockerfile ./server
docker build -t jakubhav/multi-worker-k8s:latest -t jakubhav/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push jakubhav/multi-client-k8s:latest
docker push jakubhav/multi-server-k8s-pgfix:latest
docker push jakubhav/multi-worker-k8s:latest

docker push jakubhav/multi-client-k8s:$SHA
docker push jakubhav/multi-server-k8s-pgfix:$SHA
docker push jakubhav/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=jakubhav/multi-server-k8s-pgfix:$SHA
kubectl set image deployments/client-deployment client=jakubhav/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=jakubhav/multi-worker-k8s:$SHA