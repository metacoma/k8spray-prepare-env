#!/bin/sh

docker build --no-cache . | tee /tmp/docker_build.txt && awk '/Successfully built/ {print $3}' /tmp/docker_build.txt | xargs -tI% sh -c 'docker tag % k8sprayorg/ansible:2.3.0.0 && docker push k8sprayorg/ansible:2.3.0.0'

