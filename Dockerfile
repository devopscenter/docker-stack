FROM ubuntu:trusty

ADD buildtools/utils/base-utils.sh /installs/base-utils.sh
ADD logging/papertrail.sh /installs/papertrail.sh
ADD logging/papertrailqueue.conf /installs/papertrailqueue.conf

WORKDIR /installs
RUN ./base-utils.sh
RUN ./papertrail.sh
