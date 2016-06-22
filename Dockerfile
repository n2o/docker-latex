FROM debian:jessie
MAINTAINER Christian Meter <meter@cs.uni-duesseldorf.de>

ENV DEBIAN_FRONTEND noninteractive
ENV src /etc/apt/sources.list
ENV locs /etc/locale.gen

# Remove old sources.list
RUN mv $src $src.bak
RUN touch $src

# Add local mirrors
RUN echo "deb http://mirror.cs.uni-duesseldorf.de/debian/ jessie main contrib non-free" >> $src
RUN echo "deb-src http://mirror.cs.uni-duesseldorf.de/debian/ jessie main contrib non-free" >> $src
RUN echo "deb http://httpredir.debian.org/debian jessie main" >> $src
RUN echo "deb http://httpredir.debian.org/debian jessie-updates main" >> $src
RUN echo "deb http://security.debian.org/ jessie/updates main contrib non-free" >> $src
RUN echo "deb-src http://security.debian.org/ jessie/updates main contrib non-free" >> $src

# Install packages
RUN apt-get update -qq
RUN apt-get install -qqy locales
RUN apt-get install -qqy texlive-full
RUN apt-get install -qqy python-pygments
RUN apt-get install -qqy gnuplot
RUN apt-get install -qqy inkscape
RUN apt-get install -qqy git
RUN apt-get install -qqy openssh-client

RUN gem install rake

# Create locales (needed to build latex files)
RUN mv $locs $locs.bak
RUN touch $locs
RUN echo "de_DE.UTF-8 UTF-8" >> $locs
RUN echo "en_US.UTF-8 UTF-8" >> $locs
RUN locale-gen
# Set language
ENV LANG de_DE.UTF-8
