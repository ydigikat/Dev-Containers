#!/bin/bash
VERSION="1.0.1"
docker build -t gowin-ys-dev:${VERSION} .
docker tag gowin-ys-dev:${VERSION} gowin-ys-dev:latest
