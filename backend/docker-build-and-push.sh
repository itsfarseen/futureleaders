#!/usr/bin/env bash

# Configuration, change as needed

SSH_USER=farseen
SSH_HOST=carbon

DOCKER_REGISTRY=localhost:5000
DOCKER_IMAGE_NAME=iame-be

# Setup SSH tunneling

# -M put into master mode so that it can be controlled through a socket even if
# put in background.
# -S specify the control socket
# -f put in background.
# -N Don't run any commands, just forward.
# -T Don't allocate tty
ssh -M -S ./ssh-tunnel-ctrl-socket -fNT -L 5000:localhost:5000 $SSH_USER@$SSH_HOST

# Build & push Docker image
docker build -t $DOCKER_REGISTRY/$DOCKER_IMAGE_NAME .
docker push $DOCKER_REGISTRY/$DOCKER_IMAGE_NAME

# Stop SSH tunnelling
ssh -S ./ssh-tunnel-ctrl-socket -O exit $SSH_USER@$SSH_HOST
