#!/bin/bash
VERSION="1.0.0"
docker build -t ice40-dev:${VERSION} .
docker tag ice40-dev:${VERSION} ice40-dev:latest
