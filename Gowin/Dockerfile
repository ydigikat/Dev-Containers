# Note the older LTS is needed for Gowin EDA tooling
FROM ubuntu:22.04

# The Gowin Toolchain (manually download this first)
ARG GOWIN_EDA=Gowin_V1.9.11.03_Education_Linux.tar.gz

ENV DEBIAN_FRONTEND=noninteractive
RUN useradd -m -s /bin/bash vscode

# Base build deps
RUN apt-get update && apt-get install -y build-essential git cmake && \
    rm -rf /var/lib/apt/lists/*

# Install openFPGALoader build dependencies
RUN apt-get update && apt-get install -y \
    pkg-config \
    libftdi1-2 \
    libftdi1-dev \
    libhidapi-hidraw0 \
    libhidapi-dev \
    libudev-dev \
    zlib1g-dev \
    gzip

# Build and install openFPGALoader
RUN git clone https://github.com/trabucayre/openFPGALoader.git && \
    cd openFPGALoader && \
    mkdir build && \
    cd build && \
    cmake .. && \
    cmake --build . && \
    make install && \
    cd / && \
    rm -rf openFPGALoader    

RUN apt-get install -y curl unzip    

# SystemVerilog Language Server
RUN curl -L -o /tmp/svls.zip https://github.com/dalance/svls/releases/download/v0.2.12/svls-v0.2.12-x86_64-lnx.zip \
    && unzip /tmp/svls.zip -d /tmp \
    && install -m 0755 /tmp/svls /usr/local/bin/svls \
    && rm -rf /tmp/svls /tmp/svls.zip

# QT dependencies for Gowin EDA tools
ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8
RUN apt-get update && apt-get install -y \
    libxcb-xinerama0 libxcb-cursor0 libxcb-icccm4 libxcb-image0 \
    libxcb-keysyms1 libxcb-randr0 libxcb-render-util0 libxcb-shape0 \
    qtbase5-dev qtchooser qt5-qmake qtbase5-dev-tools libqt5widgets5 \
    libqt5gui5 libqt5core5a libqt5x11extras5 \
    libnss3 \
    libasound2 \
    && rm -rf /var/lib/apt/lists/*    

# Install the gowin tooling - this needs to be local as it is behind a login wall
COPY ${GOWIN_EDA} /tmp/ 
RUN mkdir /opt/gowin/ && \    
    tar xvf ${GOWIN_EDA} -C /opt/gowin/ && \
    rm -rf ${GOWIN_EDA}
ENV PATH="/opt/gowin/IDE/bin:${PATH}"

# Update the qt.conf to point to the system plugins
RUN mv /opt/gowin/IDE/bin/qt.conf /opt/gowin/IDE/bin/qt.orig
RUN echo "[Paths]\n\rPlugins=/usr/lib/x86_64-linux-gnu/qt5/plugins/" > /opt/gowin/IDE/bin/qt.conf    

# ModelSim (downloaded at build time)
RUN curl -L -o /tmp/ModelSimSetup-20.1.1.720-linux.run \
    https://download.altera.com/akdlm/software/acdsinst/20.1std.1/720/ib_installers/ModelSimSetup-20.1.1.720-linux.run && \
    chmod +x /tmp/ModelSimSetup-20.1.1.720-linux.run && \
    yes | /tmp/ModelSimSetup-20.1.1.720-linux.run --unattendedmodeui none --mode unattended --accept_eula 1 --modelsim_edition modelsim_ase --installdir /opt/modelsim && \
    rm -rf /tmp/ModelSimSetup-20.1.1.720-linux.run

# Add ModelSim to PATH
ENV PATH="/opt/modelsim/bin:${PATH}"

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
