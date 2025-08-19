#!/bin/bash
VERSION="1.0.1"
docker build -t gowin-yosys-dev:${VERSION} .
docker tag gowin-yosys-dev:${VERSION} gowin-yosys-dev:latest
