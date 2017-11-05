FROM alpine:3.6
MAINTAINER contact@kubespray.io

RUN \
    apk update \
    && apk add --no-cache --virtual .build-deps \
      python      \
      py-pip      \
      libc-dev    \
      gcc         \
      make        \
      git         \
      openssh     \
      python-dev  \
      libffi-dev  \
      openssl-dev \
    && pip install ansible==2.3.0.0


ENTRYPOINT ansible-playbook -e env_id=$ENV_ID /opt/playbooks/prepare/playbook.yml
