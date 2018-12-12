#!/bin/bash

ANSIBLE_SSH_PIPELINING=true \
  ansible-playbook          \
  --inventory hosts         \
  --diff                    \
  "${ARGS[@]}"
