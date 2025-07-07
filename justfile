registry := "registry.fermium.xyz"

list:
	just -l

docker-push-be:
	docker build -t {{registry}}/futureleaders-backend ./backend
	docker push {{registry}}/futureleaders-backend

docker-push-fe:
	docker build -t {{registry}}/futureleaders-frontend ./frontend
	docker push {{registry}}/futureleaders-frontend
