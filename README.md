# HBASE docker image with OpenJDK 8 based on Alpine Linux

## Build

```bash
$ make build
```

## Usage

The default command simply runs hbase and exposes ports 2181 (Docker) and 34110, 16010:

```
$ docker run -d --name hbase -v /tmp/hbaselog:/usr/share/hbase/logs/ -v /tmp/hbase:/hbase-data -p 34110:34110 -p 2181:2181 -p 16010:16010 $(DOCKER_USER)/hbase
```

To access the Hbase Shell within the Docker run
```
$ docker exec -it hbase hbase shell
```

