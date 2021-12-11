FROM node:16-bullseye

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    ca-certificates \
    make \
    git \
    curl \
    clojure \
    npm

# Re-install clojure (the apt one doesn't work)
# However, we still install it via apt to install its dependencies (java, etc)
RUN cd /tmp && \
    curl -O https://download.clojure.org/install/linux-install-1.10.3.1029.sh && \
    chmod +x linux-install-1.10.3.1029.sh && \
    ./linux-install-1.10.3.1029.sh

WORKDIR /repo

RUN useradd -m -s /bin/bash -u 1001 -g 100 builder
RUN chown -R builder /repo && chmod u+rw /repo && \
    chmod 777 /opt

USER builder

