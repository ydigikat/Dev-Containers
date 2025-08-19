#!/bin/bash
VERSION="1.0.0"
docker build -t stm-dev:${VERSION} .
docker tag stm-dev:${VERSION} stm-dev:latest
