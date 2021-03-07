# Developer:
# ---------
# Name:     Ron Green
#
# Description:
# -----------
# Bash Shell v.5 bats and deps for development

FROM fedora

MAINTAINER Noah Gorny

ENV VERSION 0.2.0

# Optional Configuration Parameter
ARG SYSTEM_TZ

# Default Settings (for optional Parameter)
ENV SYSTEM_TZ ${SYSTEM_TZ:-Europe/Berlin}

ENV SERVICE_USER bashit
ENV SERVICE_HOME /home/${SERVICE_USER}

RUN dnf install --assumeyes \
		ShellCheck \
		golang \
		pip \
		python \
		python-devel \
		dumb-init \
	&& \
	dnf clean all
RUN pip3 install pre-commit

# Configure Go
RUN GO111MODULE=on go get mvdan.cc/sh/v3/cmd/shfmt && \
    ln -s ~/bin/shfmt /usr/local/bin

# create a local user so we don't use ROOT
RUN adduser --home-dir=${SERVICE_HOME} --shell=/bin/bash -u 1000 ${SERVICE_USER} && \
  cp /usr/share/zoneinfo/${SYSTEM_TZ} /etc/localtime && \
  chown -R ${SERVICE_USER}:${SERVICE_USER} ${SERVICE_HOME} && \
  sed -i -e "s/bin\/ash/bin\/bash/" /etc/passwd
USER ${SERVICE_USER}
WORKDIR ${SERVICE_HOME}

ENTRYPOINT [ "/usr/bin/dumb-init", "bash" ]

