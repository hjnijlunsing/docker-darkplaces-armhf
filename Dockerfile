FROM armbuild/debian:wheezy

# Install Quake Darkplaces
RUN apt-get update -qq && \
    apt-get install -qqy --no-install-recommends libtxc-dxtn-s2tc-dev libtxc-dxtn-s2tc-bin ca-certificates libX11-6 libjpeg8 wget lhasa unzip && \ 
    apt-get clean && \
    mkdir ~/darkplaces && \
    cd ~/darkplaces && \
    wget https://github.com/autonomous1/darkplacesrpi/archive/dprpi_v1.1.zip && \
    unzip dprpi_v1.1.zip && \
    mv darkplacesrpi-dprpi_v1.1/* . && \
    dpkg -i darkplaces-rpi.deb  && \
    wget ftp://ftp.fu-berlin.de/pc/games/idgames/idstuff/quake/quake106.zip && \
    unzip quake106.zip && \
    lhasa e resource.1

EXPOSE 26000

COPY startserver.sh /usr/local/bin/startserver.sh
COPY libvchiq_arm.so /usr/lib/libvchiq_arm.so
COPY libbcm_host.so /usr/lib/libbcm_host.so
COPY libvcos.so /usr/lib/libvcos.so
COPY libEGL.so /usr/lib/libEGL.so

ENTRYPOINT ["startserver.sh"]
