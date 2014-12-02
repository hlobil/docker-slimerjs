# - ubuntu-debootstrap/14.04
FROM ubuntu-debootstrap:14.04

# Env
ENV DEBIAN_FRONTEND     noninteractive
ENV SLIMERJS_VER        0.9.4
ENV CASPERJS_VER        1.1.0-beta3


# Install
COPY install.sh /
RUN bash -xe /install.sh


# Default command
CMD ["/usr/bin/slimerjs"]
