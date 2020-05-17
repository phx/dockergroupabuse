# dockergroupabuse

This interactive script allows you to abuse the `docker` group to get root shells from minimal images that are already stored locally on the Docker host system.

## Usage

Copy the contents of [`rootshell.sh`](rootshell.sh) to the clipboard and paste into `rootshell.sh` on the remote Docker host system.

Or if you have Internet access on the remote host, run one of the following commands:

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
