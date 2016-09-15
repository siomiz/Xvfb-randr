FROM ubuntu:14.04

MAINTAINER Tomohisa Kusano <siomiz@gmail.com>

ADD http://patchwork.freedesktop.org/patch/13852/raw/ /tmp/13852.patch

WORKDIR /usr/local/src

RUN apt-get update \
	&& apt-get install -y \
	dpkg-dev \
	&& apt-get source xvfb \
	&& apt-get build-dep -y xvfb

WORKDIR /usr/local/src/xorg-server-1.15.1

RUN patch -p1 < /tmp/13852.patch \
	&& ./autogen.sh \
	&& make

VOLUME ["/out"]

ENTRYPOINT ["cp", "hw/vfb/Xvfb", "/out/Xvfb-randr"]
