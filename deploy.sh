docker build -t hikaritanabe/multi-client:latest -t hikaritanabe/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t hikaritanabe/multi-server:latest -t hikaritanabe/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t hikaritanabe/multi-worker:latest -t hikaritanabe/multi-worker:$SHA  -f ./worker/Dockerfile ./worker
docker push hikaritanabe/multi-client:latest
docker push hikaritanabe/multi-server:latest
docker push hikaritanabe/multi-worker:latest

docker push hikaritanabe/multi-client:$SHA
docker push hikaritanabe/multi-server:$SHA
docker push hikaritanabe/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=hikaritanabe/multi-server:$SHA
kubectl set image deployment/client-deployment client=hikaritanabe/multi-client:$SHA
kubectl set image deployment/worker-deployment worker=hikaritanabe/multi-worker:$SHA
