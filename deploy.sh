docker build -t bharaj/multi-client:latest -t bharaj/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t bharaj/multi-server:latest -t bharaj/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t bharaj/multi-worker:latest -t bharaj/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push bharaj/multi-client:latest
docker push bharaj/multi-server:latest
docker push bharaj/multi-worker:latest

docker push bharaj/multi-client:$SHA
docker push bharaj/multi-server:$SHA
docker push bharaj/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=bharaj/multi-server:$SHA
kubectl set image deployments/client-deployment client=bharaj/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=bharaj/multi-worker:$SHA