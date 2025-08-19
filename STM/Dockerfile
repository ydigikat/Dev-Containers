FROM ubuntu:24.04

# The stm32cubeclt tooling
ARG CUBE_CLT=st-stm32cubeclt_1.18.0_24403_20250225_1636_amd64

# Local for Qt tools
ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8

# Early check for required files
# RUN if [ ! -e ${CUBE_CLT}.sh.zip ]; then \
#         echo "Download the stm32cubeclt from www.st.com and copy to .devcontainer" ;\
#         echo "Make sure you get the correct version: ${CUBE_CLT}.sh.zip"; \
#         exit 1; \
#     fi

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

WORKDIR /workspace