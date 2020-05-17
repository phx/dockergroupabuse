# dockergroupabuse

This interactive script allows you to abuse the `docker` group to get root shells from minimal images that are already stored locally on the Docker host.

## Usage

Copy the contents of [`rootshell.sh`](rootshell.sh) to the clipboard and paste into `rootshell.sh` on the remote Docker host system.

### Remote Docker Host
```
chmod +x rootshell.sh
./rootshell.sh
```

Take a look at [`rootshell.sh`](rootshell.sh) and feel free to modify as necessary, but this script has worked with all images and systems I have tested.

### About `sh` vs `bash`

I have defaulted to using `sh` instead of `bash` in the commands in order to be cross-compatible with Alpine-based images and such.

Feel free to call `bash` from `sh` after getting the shell.
