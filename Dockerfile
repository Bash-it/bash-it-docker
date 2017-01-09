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
# Bash Shell v.4.4 with bash-it, bats, bash-completion

FROM bash:4.4

ENV VERSION 0.0.1

RUN \
  apk add --no-cache \
    bash-completion \
    git && \
  git clone --depth 1 https://github.com/Bash-it/bash-it.git /root/.bash_it && \
    /root/.bash_it/install.sh --silent && \
  git clone --depth 1 https://github.com/sstephenson/bats.git /tmp/bats && \
    /tmp/bats/install.sh /usr/local && \
  echo -e "\n\n# Load bash-completion\n" >> /root/.bashrc && \
  echo "[ -f /usr/share/bash-completion/bash_completion ] && source /usr/share/bash-completion/bash_completion" \
    >> /root/.bashrc && \
  echo "unalias grep" >> /root/.bashrc && \
  sed -i -e "s/bin\/ash/bin\/bash/" /etc/passwd # && \
  apk del git && \
  rm -rf /tmp/*

WORKDIR /root

ENTRYPOINT [ "bash" ]

