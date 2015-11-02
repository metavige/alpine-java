FROM alpine:3.2
MAINTAINER Ricky Chiang <metavige@gmail.com>

WORKDIR /tmp

RUN apk --update add curl wget && \
  wget --no-check-certificate "https://circle-artifacts.com/gh/andyshinn/alpine-pkg-glibc/6/artifacts/0/home/ubuntu/alpine-pkg-glibc/packages/x86_64/glibc-2.21-r2.apk" && \
      apk add --allow-untrusted glibc-2.21-r2.apk  && \
  ln -s /lib/libc.musl-x86_64.so.1 /usr/lib/libc.musl-x86_64.so.1 && \
    ln -s /lib/libz.so.1 /usr/lib/libz.so.1 && \
  rm /tmp/glibc-2.21-r2.apk && \
	rm -rf /var/cache/apk/*

# Java Version
ENV JAVA_VERSION=8 \
    JAVA_UPDATE=60 \
    JAVA_BUILD=27 \
    JAVA_HOME=/usr/local/lib/java

RUN curl -jksSLH "Cookie: oraclelicense=accept-securebackup-cookie" \
    "http://download.oracle.com/otn-pub/java/jdk/${JAVA_VERSION}u${JAVA_UPDATE}-b${JAVA_BUILD}/jdk-${JAVA_VERSION}u${JAVA_UPDATE}-linux-x64.tar.gz"  \
    | gunzip -c - | tar -xf - -C /tmp && \
    mkdir -p /usr/lib/jvm && \
    mv "/tmp/jdk1.${JAVA_VERSION}.0_${JAVA_UPDATE}" "/usr/lib/jvm/java-${JAVA_VERSION}-oracle" && \
    ln -s "/usr/lib/jvm/java-${JAVA_VERSION}-oracle" $JAVA_HOME && \
    rm -rf $JAVA_HOME/*src.zip \
           $JAVA_HOME/lib/missioncontrol \
           $JAVA_HOME/lib/visualvm \
           $JAVA_HOME/lib/*javafx* \
           $JAVA_HOME/jre/lib/plugin.jar \
           $JAVA_HOME/jre/lib/ext/jfxrt.jar \
           $JAVA_HOME/jre/bin/javaws \
           $JAVA_HOME/jre/lib/javaws.jar \
           $JAVA_HOME/jre/lib/desktop \
           $JAVA_HOME/jre/plugin \
           $JAVA_HOME/jre/lib/deploy* \
           $JAVA_HOME/jre/lib/*javafx* \
           $JAVA_HOME/jre/lib/*jfx* \
           $JAVA_HOME/jre/lib/amd64/libdecora_sse.so \
           $JAVA_HOME/jre/lib/amd64/libprism_*.so \
           $JAVA_HOME/jre/lib/amd64/libfxplugins.so \
           $JAVA_HOME/jre/lib/amd64/libglass.so \
           $JAVA_HOME/jre/lib/amd64/libgstreamer-lite.so \
           $JAVA_HOME/jre/lib/amd64/libjavafx*.so \
           $JAVA_HOME/jre/lib/amd64/libjfx*.so && \
    rm -rf $JAVA_HOME/jre/bin/jjs \
           $JAVA_HOME/jre/bin/keytool \
           $JAVA_HOME/jre/bin/orbd \
           $JAVA_HOME/jre/bin/pack200 \
           $JAVA_HOME/jre/bin/policytool \
           $JAVA_HOME/jre/bin/rmid \
           $JAVA_HOME/jre/bin/rmiregistry \
           $JAVA_HOME/jre/bin/servertool \
           $JAVA_HOME/jre/bin/tnameserv \
           $JAVA_HOME/jre/bin/unpack200 \
           $JAVA_HOME/jre/lib/ext/nashorn.jar \
           $JAVA_HOME/jre/lib/jfr.jar \
           $JAVA_HOME/jre/lib/jfr \
           $JAVA_HOME/jre/lib/oblique-fonts

# Set environment
ENV PATH ${PATH}:${JAVA_HOME}/bin

