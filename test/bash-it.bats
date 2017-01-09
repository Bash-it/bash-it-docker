#!/usr/bin/env bats

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
# Simple test with bats

@test "check if we can execute bash inside the container" {
run docker run -it ellerbrock/bash-it --help
  [ "$status" -eq 0  ]
}

@test "check if bats is available" {
run docker run -it ellerbrock/bash-it -c "[[ $(which bats)  ]]"
  [ "$status" -eq 0  ]
}

@test "check if the bash-it folder exists" {
run docker run -it ellerbrock/bash-it -c "[[ -d /home/bashit/.bash_it ]]"
  [ "$status" -eq 0  ]
}

@test "check if the bash-completion folder exists" {
run docker run -it ellerbrock/bash-it -c "[[ -d /usr/share/bash-completion ]]"
  [ "$status" -eq 0  ]
}

@test "check if we run as an unprivileged user" {
run docker run -it ellerbrock/bash-it -c "[[ $(id -u) -ne 0 ]]"
  [ "$status" -eq 0  ]
}

