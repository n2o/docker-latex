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
RUN apt-get update -q
RUN apt-get install locales
RUN apt-get install -qy texlive-full
RUN apt-get install -qy python-pygments
RUN apt-get install -qy gnuplot
RUN apt-get install -qy inkscape

RUN gem install rake

# Create locales (needed to build latex files)
RUN mv $locs $locs.bak
RUN touch $locs
RUN echo "de_DE.UTF-8 UTF-8" >> $locs
RUN echo "en_US.UTF-8 UTF-8" >> $locs
RUN locale-gen
