FROM gliderlabs/alpine
MAINTAINER Ricky Chiang <metavige@gmail.com>

# Install cURL
RUN apk --update add curl

# Java Version
ENV JAVA_VERSION_MAJOR 8
ENV JAVA_VERSION_MINOR 45
ENV JAVA_VERSION_BUILD 14
ENV JAVA_PACKAGE       server-jre

RUN curl -jksSLH "Cookie: oraclelicense=accept-securebackup-cookie"\
  http://download.oracle.com/otn-pub/java/jdk/${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-b${JAVA_VERSION_BUILD}/${JAVA_PACKAGE}-${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-linux-x64.tar.gz \
    | gunzip -c - | tar -xf - -C /tmp &&\
    ln -s /tmp/1.${JAVA_VERSION_MAJOR}.0_${JAVA_VERSION_MINOR} /usr/local/lib/jdk &&\
    rm -rf /usr/local/lib/jdk/*src.zip \
           /usr/local/lib/jdk/lib/missioncontrol \
           /usr/local/lib/jdk/lib/visualvm \
           /usr/local/lib/jdk/lib/*javafx* \
           /usr/local/lib/jdk/jre/lib/plugin.jar \
           /usr/local/lib/jdk/jre/lib/ext/jfxrt.jar \
           /usr/local/lib/jdk/jre/bin/javaws \
           /usr/local/lib/jdk/jre/lib/javaws.jar \
           /usr/local/lib/jdk/jre/lib/desktop \
           /usr/local/lib/jdk/jre/plugin \
           /usr/local/lib/jdk/jre/lib/deploy* \
           /usr/local/lib/jdk/jre/lib/*javafx* \
           /usr/local/lib/jdk/jre/lib/*jfx* \
           /usr/local/lib/jdk/jre/lib/amd64/libdecora_sse.so \
           /usr/local/lib/jdk/jre/lib/amd64/libprism_*.so \
           /usr/local/lib/jdk/jre/lib/amd64/libfxplugins.so \
           /usr/local/lib/jdk/jre/lib/amd64/libglass.so \
           /usr/local/lib/jdk/jre/lib/amd64/libgstreamer-lite.so \
           /usr/local/lib/jdk/jre/lib/amd64/libjavafx*.so \
           /usr/local/lib/jdk/jre/lib/amd64/libjfx*.so

# Set environment
ENV JAVA_HOME /usr/local/lib/jdk
ENV PATH ${PATH}:${JAVA_HOME}/bin
