#!/bin/bash
VERSION="1.0.0"
docker build -t ice40-yosys-dev:${VERSION} .
docker tag ice40-yosys-dev:${VERSION} ice40-yosys-dev:latest
