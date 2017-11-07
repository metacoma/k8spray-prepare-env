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

RUN git clone https://github.com/metacoma/k8spray-workflow.git /opt/playbooks/workflow
RUN git clone https://github.com/metacoma/ansible-terraform-provision /opt/playbooks/provision
RUN git clone https://github.com/kubernetes-incubator/kubespray /opt/playbooks/kubespray
RUN ansible-galaxy install -r /opt/playbooks/workflow/requirements.yml

ENTRYPOINT ansible-playbook -e env_id=$ENV_ID /opt/playbooks/workflow/playbook.yml
