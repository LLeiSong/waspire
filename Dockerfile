FROM ubuntu:18.04

LABEL maintainer="lsong@clarku.edu"

USER root

RUN apt-get update && \
    apt-get -y install libglu1-mesa-dev

COPY WASP-v1.2.run .
RUN chmod +x WASP-v1.2.run && \
    bash ./WASP-v1.2.run --target /usr/wasp && \
    rm WASP-v1.2.run

COPY run_wasp.sh /usr/local/bin/run_wasp.sh
RUN chmod +x /usr/local/bin/run_wasp.sh

VOLUME ["/mnt/input-dir"]
VOLUME ["/mnt/output-dir"]

WORKDIR /work
RUN chmod 777 /work /mnt/output-dir

ENTRYPOINT ["/usr/local/bin/run_wasp.sh"]
CMD ["--help"]
