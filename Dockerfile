# This Dockerfile combines the latest node docker image and isntall java runtime to form a gitlab-ci
# build machine for JavaScript web projects

FROM node:latest
MAINTAINER Rubin D. Mendoza <darkcloud1801@gmail.com>

# Default to UTF-8 file.encoding
ENV LANG C.UTF-8

ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64
ENV JAVA_VERSION 7u95
ENV JAVA_DEBIAN_VERSION 7u95-2.6.4-1~deb8u1

########
# Java
########

RUN apt-get update && apt-get install -y unzip && rm -rf /var/lib/apt/lists/*

# add a simple script that can auto-detect the appropriate JAVA_HOME value
# based on whether the JDK or only the JRE is installed
RUN { \
		echo '#!/bin/bash'; \
		echo 'set -e'; \
		echo; \
		echo 'dirname "$(dirname "$(readlink -f "$(which javac || which java)")")"'; \
	} > /usr/local/bin/docker-java-home \
	&& chmod +x /usr/local/bin/docker-java-home

RUN set -x \
	&& apt-get update \
	&& apt-get install -y \
		openjdk-7-jdk="$JAVA_DEBIAN_VERSION" \
	&& rm -rf /var/lib/apt/lists/* \
	&& [ "$JAVA_HOME" = "$(docker-java-home)" ]