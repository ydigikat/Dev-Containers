#
# Gowin development tools for Tang 9/20K
#

FROM ubuntu:22.04

# Install openFPGALoader build dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    cmake \
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

# Install QT5 dependencies, the gowin tools (even the console ones) require this.
# Local for Qt tools
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

# Install svls (SystemVerilog Language Server)
RUN curl -L -o svls.zip https://github.com/dalance/svls/releases/download/v0.2.12/svls-v0.2.12-x86_64-lnx.zip && \
    unzip svls.zip && \
    mv svls /usr/local/bin/ && \
    chmod +x /usr/local/bin/svls && \
    rm -rf svls.zip

# Install the gowin tooling - this needs to be local as it is behind a login wall
COPY Gowin_V1.9.11.03_Education_Linux.tar.gz /tmp/ 
RUN mkdir /opt/gowin/ && \    
    tar xvf /tmp/Gowin_V1.9.11.03_Education_Linux.tar.gz -C /opt/gowin/ && \
    rm -rf /tmp/Gowin_V1.9.11.03_Education_Linux.tar.gz

# Update the qt.conf to point to the system plugins
RUN mv /opt/gowin/IDE/bin/qt.conf /opt/gowin/IDE/bin/qt.orig
RUN echo "[Paths]\n\rPlugins=/usr/lib/x86_64-linux-gnu/qt5/plugins/" > /opt/gowin/IDE/bin/qt.conf

# Udev rules
# Bus 001 Device 012: ID 0403:6010 Future Technology Devices International, Ltd FT2232C/D/H Dual UART/FIFO IC
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    udev libusb-1.0-0 usbutils \
    && rm -rf /var/lib/apt/lists/* \
    && echo 'SUBSYSTEM=="usb", ATTRS{idVendor}=="0403", ATTRS{idProduct}=="6010", MODE="0666"' > /etc/udev/rules.d/53-tang-ftdi.rules
    
# Add Gowin tools to PATH
ENV PATH="/opt/gowin/IDE/bin:$PATH"
    
WORKDIR /workspace
