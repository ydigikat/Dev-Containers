#!/bin/bash
VERSION="1.18.0"
docker build -t stm32-dev-base:${VERSION} .
docker tag stm32-dev-base:${VERSION} stm32-dev-base:latest