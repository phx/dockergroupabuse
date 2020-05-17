FROM alpine

RUN echo "$(which chroot) /host /bin/sh" >> /root/.profile

ENTRYPOINT ["/bin/sh", "-l"]
