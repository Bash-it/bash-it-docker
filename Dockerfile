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
# Bash Shell v.4.4 with Bash-it, bats, bash-completion

FROM bash:4.4

MAINTAINER Maik Ellerbrock

ENV VERSION 0.0.3
ENV DUMP_INIT_VERSION 1.2.0
ENV SERVICE_USER bashit
ENV SERVICE_HOME /home/${SERVICE_USER}

RUN \
  adduser -h ${SERVICE_HOME} -s /bin/bash -u 1000 -D ${SERVICE_USER} && \
  apk add --no-cache \
    bash-completion \
    git \
    openssl && \
  git clone --depth 1 https://github.com/Bash-it/bash-it.git ${SERVICE_HOME}/.bash_it && \
  git clone --depth 1 https://github.com/sstephenson/bats.git /tmp/bats && \
    /tmp/bats/install.sh /usr/local && \
  wget -O /usr/local/bin/dumb-init \
    https://github.com/Yelp/dumb-init/releases/download/v${DUMP_INIT_VERSION}/dumb-init_${DUMP_INIT_VERSION}_amd64 && \
  chmod +x /usr/local/bin/dumb-init && \
  chown -R ${SERVICE_USER}:${SERVICE_USER} ${SERVICE_HOME} && \
  sed -i -e "s/bin\/ash/bin\/bash/" /etc/passwd && \
  apk del git openssl && \
  rm -rf /tmp/*

USER ${SERVICE_USER}

WORKDIR ${SERVICE_HOME}

RUN \
  ${SERVICE_HOME}/.bash_it/install.sh --silent && \
  echo -e "\n\n# Load bash-completion" >> ${SERVICE_HOME}/.bashrc && \
  echo "[ -f /usr/share/bash-completion/bash_completion ] && source /usr/share/bash-completion/bash_completion" \
    >> ${SERVICE_HOME}/.bashrc

ENTRYPOINT [ "/usr/local/bin/dumb-init", "--", "bash" ]

