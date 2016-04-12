CURRENT_DIRECTORY := $(shell pwd)
include environment

build:
	sed -i.bak 's|^FROM.*|FROM $(DOCKER_OPENJRE)|' Dockerfile && \
	docker build --build-arg HBASE_VERSION=$(HBASE_VERSION) --build-arg HBASE_DOWNLOAD_URL=$(HBASE_DOWNLOAD_URL) -t $(DOCKER_USER)/hbase --rm=true . && \
	mv Dockerfile.bak Dockerfile

debug:
	docker run -it -v /tmp/hbaselog:/usr/share/hbase/logs/ -v /tmp/hbase:/hbase-data -p 34110:34110 -p 2181:2181 -p 16010:16010 --entrypoint=sh $(DOCKER_USER)/hbase

run:
	docker run -d --name hbase -v /tmp/hbaselog:/usr/share/hbase/logs/ -v /tmp/hbase:/hbase-data -p 34110:34110 -p 2181:2181 -p 16010:16010 $(DOCKER_USER)/hbase
