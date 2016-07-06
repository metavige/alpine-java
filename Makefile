IMAGE=alpine-java:8u91

build:
	docker build -t ${IMAGE} .

build-minimal:
	docker build -t ${IMAGE} -f Dockerfile.minimal .

push:
	docker push ${IMAGE}
