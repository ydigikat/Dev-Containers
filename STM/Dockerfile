FROM ubuntu:24.04

# The stm32cubeclt tooling
ARG CUBE_CLT=st-stm32cubeclt_1.18.0_24403_20250225_1636_amd64

# Local for Qt tools
ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8

# Create vscode user
RUN useradd -m -s /bin/bash vscode

# Install base development tooling & X11 files needed by JLink software
RUN apt-get update && apt-get install -y \
    cmake ninja-build git curl xz-utils udev unzip \
    libusb-1.0-0 usbutils minicom file xxd less \                    
    libxrender1 libxcb-render0 libxcb-render-util0 libxcb-shape0 \
    libxcb-randr0 libxcb-xfixes0 libxcb-sync1 libxcb-shm0 libxcb-icccm4 \
    libxcb-keysyms1 libxcb-image0 libxkbcommon0 libxkbcommon-x11-0 \
    libx11-xcb1 libsm6 libice6 sudo wget \
    && rm -rf /var/lib/apt/lists/*

# Copy manually downloaded installer
COPY ${CUBE_CLT}.sh.zip /tmp/

# Untar, ignore shell scripts for st-link server as not used.
RUN mkdir /opt/st/ /opt/st/stm32cubeclt/ \
    && cd /tmp/ \
    && unzip ${CUBE_CLT}.sh.zip \
    && chmod +x ${CUBE_CLT}.sh \
    && ./${CUBE_CLT}.sh --noexec --target /tmp/cubeclt \
    && tar -xvf cubeclt/${CUBE_CLT}.tar.gz -C /opt/st/stm32cubeclt/ \
    && rm -rf cubeclt \
    && rm ${CUBE_CLT}.sh.zip ${CUBE_CLT}.sh

# Install JLink and handle expected container failures (udevadm - no systemd) gracefully
RUN wget -q --post-data 'accept_license_agreement=accepted&non_emb_ctr=confirmed' https://www.segger.com/downloads/jlink/JLink_Linux_x86_64.deb \
    && dpkg -i JLink_Linux_x86_64.deb 2>/dev/null || true \
    && rm JLink_Linux_x86_64.deb

# ensure sane /tmp and give vscode sudo once
RUN chmod 1777 /tmp \
 && echo "vscode ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/vscode \
 && chmod 0440 /etc/sudoers.d/vscode \
 && chown -R vscode:vscode /home/vscode

# Add vscode to dialout group
RUN groupadd -f dialout && usermod -a -G dialout vscode

 # Switch from root user
USER vscode


WORKDIR /workspace