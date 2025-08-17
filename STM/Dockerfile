FROM ubuntu:24.04

# The stm32cubeclt tooling
ARG CUBE_CLT=st-stm32cubeclt_1.18.0_24403_20250225_1636_amd64.sh

# Local for Qt tools
ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8

# Early check for required files
#RUN if [ ! -e ${CUBE_CLT} ]; then \
#        echo "Download the stm32cubeclt from www.st.com and copy to .devcontainer" ;\
#        echo "Make sure you get the correct version: ${CUBE_CLT}"; \
#        exit 1; \
#    fi

# Install base development tooling
RUN apt-get update && apt-get install -y \
                    cmake \
                    ninja-build \
                    git \
                    wget \
                    curl \
                    xz-utils \
                    udev unzip \
                    libusb-1.0-0 \
                    usbutils \
                    minicom \
                    file \
                    xxd \
                    less \                    
    && rm -rf /var/lib/apt/lists/*

# Install the STM command line tools
# Can't use wget because the zip is behind an account wall.
# RUN wget -q https://www.st.com/content/ccc/resource/technical/software/sw_development_suite/group0/62/8f/55/8d/85/4b/42/2b/stm32cubeclt_linux_v1.18.0.zip 

# Copy manually downloaded installer
COPY st-stm32cubeclt_1.18.0_24403_20250225_1636_amd64.sh /tmp/


# Untar the files I need directly, ignore the shell scripts that setup st-link server as I don't use it.
RUN mkdir /opt/st/ /opt/st/stm32cubeclt_1.18.0/ \
    &&  chmod +x /tmp/st-stm32cubeclt_1.18.0_24403_20250225_1636_amd64.sh \
    && /tmp/st-stm32cubeclt_1.18.0_24403_20250225_1636_amd64.sh --noexec --target /tmp/cubeclt \
    && tar -xvf /tmp/cubeclt/st-stm32cubeclt_1.18.0_24403_20250225_1636_amd64.tar.gz -C /opt/st/stm32cubeclt_1.18.0/ \
    && rm -rf /tmp/cubeclt



# Install JLink support - note this has dependencies on X11 which we need to install but which 
# won't ever be used.

RUN apt-get update && apt-get install -y \
    libxrender1 \
    libxcb-render0 \
    libxcb-render-util0 \
    libxcb-shape0 \
    libxcb-randr0 \
    libxcb-xfixes0 \
    libxcb-sync1 \
    libxcb-shm0 \
    libxcb-icccm4 \
    libxcb-keysyms1 \
    libxcb-image0 \
    libxkbcommon0 \
    libxkbcommon-x11-0 \
    libx11-xcb1 \
    libsm6 \
    libice6 \
    && rm -rf /var/lib/apt/lists/*

# Install JLink and handle expected container failures (udevadm - no systemd) gracefully
RUN wget -q --post-data 'accept_license_agreement=accepted&non_emb_ctr=confirmed' https://www.segger.com/downloads/jlink/JLink_Linux_x86_64.deb \
    && dpkg -i JLink_Linux_x86_64.deb 2>/dev/null || true \
    && rm JLink_Linux_x86_64.deb

# udev rules for JLink and ST-Link
RUN echo 'SUBSYSTEM=="usb", ATTR{idVendor}=="1366", MODE="0666"' > /etc/udev/rules.d/99-jlink.rules \
    && echo 'SUBSYSTEM=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="3748", MODE="0666"' >> /etc/udev/rules.d/99-jlink.rules

WORKDIR /workspace