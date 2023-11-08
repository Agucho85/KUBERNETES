#!/bin/bash
/etc/eks/bootstrap.sh ${cluster} \
  --use-max-pods false \
  --kubelet-extra-args '--max-pods=${max_pods}'