# Use an Ubuntu-based image
FROM ubuntu:24.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive \
    DISPLAY=:0 \
    QT_X11_NO_MITSHM=1 \
    GDK_BACKEND=x11

# Update the system and install dependencies
RUN apt-get update && apt-get install -y \
    gedit \
    libcanberra-gtk-module \
    libcanberra-gtk3-module \
    libatk-adaptor \
    at-spi2-core \
    wget \
    curl \
    tar \
    gdebi-core \
    libgtk-3-0 \
    libgdk-pixbuf2.0-0 \
    p7zip-full \
    xdg-utils \
    libfile-copy-recursive-perl \
    libopengl0 \
    libgomp1 \
    libnss3 \
    libegl1 \
    libglx0 \
    libxcb1 \
    libxcb-xfixes0 \
    libxcb-render-util0 \
    libxcb-icccm4 \
    libxcb-image0 \
    libxcb-keysyms1 \
    libxcb-randr0 \
    libxcb-shape0 \
    libxcb-util1 \
    libxcb-xinerama0 \
    libxcb-xkb1 \
    libxcb-cursor0 \
    libxkbcommon-x11-0 \
    libxkbcommon0 \
    libfontconfig1 \
    libfreetype6 \
    qt5dxcb-plugin \
    less \
    ca-certificates \
    x11-apps \
    --no-install-recommends && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Ensure CA certificates are updated
RUN update-ca-certificates

# Copy the CEWE Fotowelt Linux installer into the container
COPY setup_CEWE_Fotowelt.tgz /tmp/setup_CEWE_Fotowelt.tgz

WORKDIR /tmp
RUN tar -xvzf /tmp/setup_CEWE_Fotowelt.tgz -C /opt/ && \
    rm /tmp/setup_CEWE_Fotowelt.tgz && \
	/opt/install.pl --update -k --installDir="/opt/CEWE/CEWE Fotowelt" -v


run echo "#!/bin/bash" > /entrypoint.sh && echo "/opt/CEWE/CEWE\ Fotowelt/CEWE\ Fotowelt" >> /entrypoint.sh && chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
