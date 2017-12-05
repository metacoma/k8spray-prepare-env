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
    && pip install netaddr configparser ansible==2.3.0.0

#RUN git clone https://github.com/metacoma/k8spray-workflow.git /opt/playbooks/workflow
ADD ./ /opt/playbooks/workflow
RUN git clone https://github.com/kubernetes-incubator/kubespray /opt/playbooks/kubespray
WORKDIR /opt/playbooks/kubespray
RUN git checkout ca8a9c600a629ae19ee30f94c515fcc153279e3d
WORKDIR /opt/playbooks/workflow
RUN ansible-galaxy install -r /opt/playbooks/workflow/requirements.yml

ENTRYPOINT ["/bin/sh", "-c"]
