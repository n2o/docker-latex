FROM debian:jessie
MAINTAINER Christian Meter <meter@cs.uni-duesseldorf.de>

ENV DEBIAN_FRONTEND noninteractive
ENV src /etc/apt/sources.list

# Remove old sources.list
RUN rm $src
RUN touch $src

# Add local mirrors
RUN echo "deb http://mirror.cs.uni-duesseldorf.de/debian/ jessie main contrib non-free" >> $src
RUN echo "deb-src http://mirror.cs.uni-duesseldorf.de/debian/ jessie main contrib non-free" >> $src
RUN echo "deb http://httpredir.debian.org/debian jessie main" >> $src
RUN echo "deb http://httpredir.debian.org/debian jessie-updates main" >> $src
RUN echo "deb http://security.debian.org/ jessie/updates main contrib non-free" >> $src
RUN echo "deb-src http://security.debian.org/ jessie/updates main contrib non-free" >> $src

RUN apt-get update -q
RUN apt-get install -qy texlive-full
RUN apt-get install -qy python-pygments
RUN apt-get install -qy gnuplot
RUN apt-get install -qy inkscape

RUN gem install rake
