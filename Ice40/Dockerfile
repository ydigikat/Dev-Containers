# Yosys development for ICE40
FROM ubuntu:24.04

# Create vscode user
RUN useradd -m -s /bin/bash vscode

# Build tools
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    build-essential clang bison flex libreadline-dev \
    gawk tcl-dev libffi-dev git mercurial graphviz \
    xdot pkg-config python3 python3-dev python3-pip \
    libftdi-dev qtbase5-dev python3-dev libboost-all-dev \
    cmake libeigen3-dev curl xz-utils unzip minicom sudo \
    file xxd less && rm -rf /var/lib/apt/lists/*

# Icestorm ChipDb
RUN git clone --recursive https://github.com/YosysHQ/icestorm.git && \
    cd icestorm && make -j$(nproc) && make install

# Yosys synthesis    
RUN git clone --recursive https://github.com/YosysHQ/yosys.git && \
    cd yosys && make -j$(nproc) && make install

# Nexpnr place and route
RUN git clone --recursive https://github.com/YosysHQ/nextpnr.git && \
    cd nextpnr && \
    mkdir -p build && \
    cd build && \
    cmake .. -DARCH=ice40 && \
    make -j$(nproc) && \
    make install

# Simulation 
RUN apt-get update && apt-get install -y iverilog gtkwave
    
# SVLS 
RUN curl -L -o svls.zip https://github.com/dalance/svls/releases/download/v0.2.12/svls-v0.2.12-x86_64-lnx.zip && \
    unzip svls.zip && \
    mv svls /usr/local/bin/ && \
    chmod +x /usr/local/bin/svls && \
    rm -rf svls.zip

# ensure sane /tmp and give vscode sudo once
RUN chmod 1777 /tmp \
 && apt-get update && apt-get install -y sudo \
 && echo "vscode ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/vscode \
 && chmod 0440 /etc/sudoers.d/vscode \
 && chown -R vscode:vscode /home/vscode

# Add vscode to dialout group
RUN groupadd -f dialout && usermod -a -G dialout vscode

 # Switch from root user
USER vscode

    
WORKDIR /workspace