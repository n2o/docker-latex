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

# Add ssh host key of our Gitlab Server
RUN echo "gitlab.cs.uni-duesseldorf.de ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDBZ3qJ6fZILnAaknonZYF6uf3rL2WcgPCMFbdnTBfjzS+5HxIVSvmNfCSX88bgZw+c3I/Hz5kxcpWyD0RdE0wlCDsHhG2A45rKFnBj3Rf3FhCypxze8/PpxfIeOIsfTMw9aH7B2uo2fPuivNyz3G/Z0HdALHvSROmSlCiQONxXb5QErEZSdYC7IWqt4grRuwSPerI7i5giwn1KNZ5ifEoat/u6CkwkPavzgSV30RM76ZvG/eBrPb+OJ0hthQ7q3AND1Bh5UXW32L4Aip3zY9rsSvcrMvbgE9jHNGzbi3SsbOj6bgoF4R6Nfn201XHK/ZKwokPJYPUbzYNxI+4x6qin" >> /home/root/.ssh/known_hosts
