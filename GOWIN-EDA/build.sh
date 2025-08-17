#!/bin/bash
VERSION="1.0.0"
docker build -t gowin-eda-dev:${VERSION} .
docker tag gowin-eda-dev:${VERSION} gowin-eda-dev:latest
