# Developer:
# ---------
# Name:      Maik Ellerbrock
#
# GitHub:    https://github.com/ellerbrock
# Twitter:   https://twitter.com/frapsoft
# Docker:    https://hub.docker.com/u/ellerbrock
# Quay:      https://quay.io/user/ellerbrock
#
# Description:
# -----------
# Bash Shell v.5 bats and deps for development

FROM bash:5

MAINTAINER Maik Ellerbrock

ENV VERSION 0.1.0

# Optional Configuration Parameter
ARG SYSTEM_TZ

# Default Settings (for optional Parameter)
ENV SYSTEM_TZ ${SYSTEM_TZ:-Europe/Berlin}

ENV SERVICE_USER bashit
ENV SERVICE_HOME /home/${SERVICE_USER}

# Configure Go
ENV GOROOT /usr/lib/go
ENV GOPATH ${SERVICE_HOME}/go

RUN \
  adduser -h ${SERVICE_HOME} -s /bin/bash -u 1000 -D ${SERVICE_USER} && \
  apk add --no-cache \
    dumb-init \
    git \
    go \
    py3-pip \
    python3 \ 
    python3-dev \
    shellcheck \ 
    tzdata && \
  cp /usr/share/zoneinfo/${SYSTEM_TZ} /etc/localtime && \
  echo "${SYSTEM_TZ}" > /etc/TZ && \
  pip3 install pre-commit && \
  GO111MODULE=on go get mvdan.cc/sh/v3/cmd/shfmt && \
    ln -s ${GOPATH}/bin/shfmt /usr/local/bin \ 
  git clone --depth 1 https://github.com/sstephenson/bats.git /tmp/bats && \
    /tmp/bats/install.sh /usr/local && \
  chown -R ${SERVICE_USER}:${SERVICE_USER} ${SERVICE_HOME} && \
  sed -i -e "s/bin\/ash/bin\/bash/" /etc/passwd && \
  apk del git tzdata && \
  rm -rf /tmp/{.}* /tmp/*

USER ${SERVICE_USER}

WORKDIR ${SERVICE_HOME}

ENTRYPOINT [ "/usr/bin/dumb-init", "bash" ]

