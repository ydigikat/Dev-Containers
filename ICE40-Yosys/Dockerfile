#
# Yosys development environment for ICE40
#

FROM ubuntu:24.04

# Build tools
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    build-essential clang bison flex libreadline-dev \
    gawk tcl-dev libffi-dev git mercurial graphviz \
    xdot pkg-config python3 python3-dev python3-pip \
    libftdi-dev qtbase5-dev python3-dev libboost-all-dev \
    cmake libeigen3-dev

# ICE40 toolchain from source
RUN git clone --recursive https://github.com/YosysHQ/icestorm.git && \
    cd icestorm && make -j$(nproc) && make install

RUN git clone --recursive https://github.com/YosysHQ/yosys.git && \
    cd yosys && make -j$(nproc) && make install

RUN git clone --recursive https://github.com/YosysHQ/nextpnr.git && \
    cd nextpnr && \
    mkdir -p build && \
    cd build && \
    cmake .. -DARCH=ice40 && \
    make -j$(nproc) && \
    make install

# Simulation tools
RUN apt-get install -y iverilog gtkwave

# udev rules for IceStick FTDI programmer
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    udev libusb-1.0-0 usbutils \
    && rm -rf /var/lib/apt/lists/* \
    && echo 'SUBSYSTEM=="usb", ATTRS{idVendor}=="0403", ATTRS{idProduct}=="6010", MODE="0666"' > /etc/udev/rules.d/53-lattice-ftdi.rules \
    && echo 'SUBSYSTEM=="usb", ATTRS{idVendor}=="0403", ATTRS{idProduct}=="6014", MODE="0666"' >> /etc/udev/rules.d/53-lattice-ftdi.rules

# Useful utilities
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
                    wget \
                    curl \
                    xz-utils \
                    unzip \                                        
                    minicom \
                    file \
                    xxd \
                    less \                    
    && rm -rf /var/lib/apt/lists/*

# Install Verible
RUN curl -L -o verible.tar.gz https://github.com/chipsalliance/verible/releases/download/v0.0-4011-g03c61290/verible-v0.0-4011-g03c61290-linux-static-arm64.tar.gz && \
    tar -xzf verible.tar.gz && \
    mv verible-* /opt/verible && \
    ln -s /opt/verible/bin/* /usr/local/bin/  && \
    rm verible.tar.gz
    
# Install svls (SystemVerilog Language Server)
RUN curl -L -o svls.zip https://github.com/dalance/svls/releases/download/v0.2.12/svls-v0.2.12-x86_64-lnx.zip && \
    unzip svls.zip && \
    mv svls /usr/local/bin/ && \
    chmod +x /usr/local/bin/svls && \
    rm -rf svls.zip
    

WORKDIR /workspace