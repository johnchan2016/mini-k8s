docker build -t stephengrider/multi-client -t stephengrider/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t stephengrider/multi-server -t stephengrider/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t stephengrider/multi-worker -t stephengrider/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push stephengrider/multi-client
docker push stephengrider/multi-server
docker push stephengrider/multi-worker

docker push stephengrider/multi-client:$SHA
docker push stephengrider/multi-server:$SHA
docker push stephengrider/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=stephengrider/multi-client:$SHA
kubectl set image deployments/server-deployment server=stephengrider/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=stephengrider/multi-worker:$SHA