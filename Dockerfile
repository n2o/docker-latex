FROM debian:bullseye
LABEL org.opencontainers.image.authors="cmeter@googlemail.com"

ENV DEBIAN_FRONTEND noninteractive
ENV locs /etc/locale.gen

# Install packages
RUN apt-get update -qq && \
    apt-get install -yqq locales texlive-full gnuplot inkscape git openssh-client && \
    gem install rake

# Create locales (needed to build latex files)
RUN mv $locs $locs.bak && \
    touch $locs && \
    echo "de_DE.UTF-8 UTF-8" >> $locs && \
    echo "en_US.UTF-8 UTF-8" >> $locs && \
    locale-gen

# Set language
ENV LANG de_DE.UTF-8
