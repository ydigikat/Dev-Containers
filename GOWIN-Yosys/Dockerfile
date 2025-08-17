FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive
RUN useradd -m -s /bin/bash vscode

# Base build deps
RUN apt-get update && apt-get install -y \
    build-essential clang bison flex libreadline-dev \
    gawk tcl-dev libffi-dev git graphviz xdot pkg-config \
    python3 python3-dev python3-pip pybind11-dev \
    libboost-all-dev cmake libeigen3-dev libftdi-dev \
    wget curl xz-utils unzip minicom file xxd less \
    && rm -rf /var/lib/apt/lists/*

# Chipdb/packer (Apycula)
ENV PIP_BREAK_SYSTEM_PACKAGES=1 PIP_DISABLE_PIP_VERSION_CHECK=1
RUN python3 -m pip install --no-cache-dir apycula

# Yosys (synthesis)
RUN git clone --recursive https://github.com/YosysHQ/yosys.git /opt/yosys && \
    make -C /opt/yosys -j"$(nproc)" && make -C /opt/yosys install

# nextpnr (Gowin via himbaechel; no GUI)
RUN git clone --recursive https://github.com/YosysHQ/nextpnr.git /opt/nextpnr && \
    mkdir -p /opt/nextpnr/build && cd /opt/nextpnr/build && \
    cmake .. -DARCH=himbaechel -DHIMBAECHEL_UARCH=gowin -DBUILD_GUI=OFF && \
    make -j"$(nproc)" && make install

# Simulation tools
RUN apt-get update && apt-get install -y iverilog gtkwave verilator \
    && rm -rf /var/lib/apt/lists/*

# openFPGALoader (programmer) — available in Ubuntu 24.04
RUN apt-get update && apt-get install -y openfpgaloader \
    && rm -rf /var/lib/apt/lists/*

# SystemVerilog Language Server
RUN curl -L -o /tmp/svls.zip https://github.com/dalance/svls/releases/download/v0.2.12/svls-v0.2.12-x86_64-lnx.zip \
    && unzip /tmp/svls.zip -d /tmp \
    && install -m 0755 /tmp/svls /usr/local/bin/svls \
    && rm -rf /tmp/svls /tmp/svls.zip

# ensure sane /tmp and give vscode sudo once
RUN chmod 1777 /tmp \
 && apt-get update && apt-get install -y sudo \
 && echo "vscode ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/vscode \
 && chmod 0440 /etc/sudoers.d/vscode \
 && chown -R vscode:vscode /home/vscode

# Ensure dialout group exists and add vscode user to it for programming without sudo
RUN groupadd -f dialout && usermod -a -G dialout vscode

 # Switch from root user (too dangerous)
USER vscode

WORKDIR /workspace
