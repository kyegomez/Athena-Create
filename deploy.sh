#!/usr/bin/env bash
VERSION=0.0.4

cd ui || exit 1

npm install
npm run build

cd ..

mkdir -p $HOME/.athena/.buildx-cache

sudo docker buildx create --use
sudo docker buildx build --platform linux/amd64,linux/arm64 \
  --cache-from type=local,src=$HOME/.athena/.buildx-cache \
  --cache-to type=local,dest=$HOME/.athena/.buildx-cache \
  -t athena/athena:$VERSION . \
  -t athena/athena:latest --push