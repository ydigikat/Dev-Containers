#!/bin/bash
VERSION="1.0.0"
docker build -t stm32-dev:${VERSION} .
docker tag stm32-dev:${VERSION} stm32-dev:latest
