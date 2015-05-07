all: docker

docker: Dockerfile
	docker build --rm=true -t themurph/atomic-consul-server .
