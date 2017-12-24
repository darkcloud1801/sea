# This Dockerfile combines the latest node docker image and isntall java runtime to form a gitlab-ci
# build machine for JavaScript web projects

FROM node:latest
MAINTAINER Rubin D. Mendoza <darkcloud1801@gmail.com>

# Default to UTF-8 file.encoding
ENV LANG C.UTF-8

ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64
ENV JAVA_VERSION 7u95
ENV JAVA_DEBIAN_VERSION 7u95-2.6.4-1~deb8u1
ENV DEBIAN_FRONTEND noninteractive

########
# Java
########
RUN apt-get update && apt-get install -y --no-install-recommends apt-utils
RUN apt-get -y install python-software-properties
RUN apt-get -y install apt-file
RUN apt-file update
RUN apt-get -y install software-properties-common
RUN echo "deb http://http.debian.net/debian jessie-backports main" > /etc/apt/sources.list.d/jessie-backports.list
RUN apt-get update && apt-get install --fix-missing
RUN apt-get install -y -t jessie-backports  openjdk-8-jre-headless ca-certificates-java
RUN apt-get install -y openjdk-8-jdk

# install manually all the missing libraries
RUN apt-get install -y gconf-service libasound2 libatk1.0-0 libcairo2 libcups2 libfontconfig1 libgdk-pixbuf2.0-0 libgtk-3-0 libnspr4 libpango-1.0-0 libxss1 fonts-liberation libappindicator1 libnss3 lsb-release xdg-utils

# install chrome
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
RUN dpkg -i google-chrome-stable_current_amd64.deb; apt-get -fy install
