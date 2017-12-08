FROM hashicorp/terraform:latest
MAINTAINER contact@kubespray.io

RUN \
    apk update \
    && apk add --no-cache --virtual .build-deps \
      jq          \
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
    && pip install netaddr configparser ansible==2.4.0.0

RUN git clone https://github.com/metacoma/k8spray-workflow.git /opt/playbooks/workflow
#ADD ./ /opt/playbooks/workflow
RUN git clone https://github.com/kubernetes-incubator/kubespray /opt/playbooks/kubespray
WORKDIR /opt/playbooks/kubespray
RUN git checkout 626b35e1b023a682a0ea4c623bd25f773d00e911
WORKDIR /opt/playbooks/workflow
RUN ansible-galaxy install -r /opt/playbooks/workflow/requirements.yml

ENTRYPOINT ["/bin/sh", "-c"]
