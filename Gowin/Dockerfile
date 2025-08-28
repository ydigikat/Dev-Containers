# Ubuntu core (older LTS is needed for Gowin tools)
FROM ubuntu:22.04

# The Gowin Toolchain (manually download this first)
ARG GOWIN_EDA=Gowin_V1.9.11.03_Education_Linux.tar.gz

ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8

# Required packages
RUN apt-get update && apt-get install -y build-essential git cmake \
    libxcb-xinerama0 libxcb-cursor0 libxcb-icccm4 libxcb-image0 \
    libxcb-keysyms1 libxcb-randr0 libxcb-render-util0 libxcb-shape0 \
    qtbase5-dev qtchooser qt5-qmake qtbase5-dev-tools libqt5widgets5 \
    libqt5gui5 libqt5core5a libqt5x11extras5 curl unzip \
    libnss3 libasound2 pkg-config libftdi1-2 libftdi1-dev libhidapi-hidraw0 \
    libhidapi-dev libudev-dev zlib1g-dev gzip && \
    rm -rf /var/lib/apt/lists/*

# Build and install openFPGALoader (not a package in 22.04)
RUN git clone https://github.com/trabucayre/openFPGALoader.git && \
    cd openFPGALoader && \
    mkdir build && \
    cd build && \
    cmake .. && \
    cmake --build . && \
    make install && \
    cd / && \
    rm -rf openFPGALoader    

# SystemVerilog Language Server
RUN curl -L -o /tmp/svls.zip https://github.com/dalance/svls/releases/download/v0.2.12/svls-v0.2.12-x86_64-lnx.zip \
    && unzip /tmp/svls.zip -d /tmp \
    && install -m 0755 /tmp/svls /usr/local/bin/svls \
    && rm -rf /tmp/svls /tmp/svls.zip

# Install the gowin tooling - this needs to be from a local copy as it is behind a login wall
COPY ${GOWIN_EDA} /tmp/ 
RUN mkdir /opt/gowin/ && \    
    tar xvf /tmp/${GOWIN_EDA} -C /opt/gowin/ && \
    rm -rf /tmp/${GOWIN_EDA}
ENV PATH="/opt/gowin/IDE/bin:${PATH}"

# Update the Gowin qt.conf to point to the system plugins
RUN mv /opt/gowin/IDE/bin/qt.conf /opt/gowin/IDE/bin/qt.orig
RUN echo "[Paths]\n\rPlugins=/usr/lib/x86_64-linux-gnu/qt5/plugins/" > /opt/gowin/IDE/bin/qt.conf    

# Download and install ModelSim (big and slow install)
# RUN curl -L -o /tmp/ModelSimSetup-20.1.1.720-linux.run \
#     https://download.altera.com/akdlm/software/acdsinst/20.1std.1/720/ib_installers/ModelSimSetup-20.1.1.720-linux.run && \
#     chmod +x /tmp/ModelSimSetup-20.1.1.720-linux.run && \
#     yes | /tmp/ModelSimSetup-20.1.1.720-linux.run --unattendedmodeui none --mode unattended --accept_eula 1 --modelsim_edition modelsim_ase --installdir /opt/modelsim && \
#     rm -rf /tmp/ModelSimSetup-20.1.1.720-linux.run
# ENV PATH="/opt/modelsim/bin:${PATH}"

# Make /opt tools usable by non-root (keep these)
RUN find /opt/gowin -type d -exec chmod a+rx {} \; && \
    find /opt/gowin -type f -exec chmod a+r {} \; && \
    find /opt/gowin/IDE/bin -type f -exec chmod a+rx {} \; || true

RUN find /opt/modelsim -type d -exec chmod a+rx {} \; && \
    find /opt/modelsim -type f -exec chmod a+r {} \; && \
    find /opt/modelsim/bin -type f -exec chmod a+rx {} \; || true

# Keep sudo available for postStart chown
RUN apt-get update && apt-get install -y --no-install-recommends sudo && \
    rm -rf /var/lib/apt/lists/*

# Do NOT set USER here (devcontainer will)
WORKDIR /workspace