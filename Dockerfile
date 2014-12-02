# - ubuntu-debootstrap/14.04
FROM ubuntu-debootstrap:14.04

# Env
ENV DEBIAN_FRONTEND     noninteractive
ENV SLIMERJSLAUNCHER    /usr/bin/firefox
ENV SLIMERJS_GIT_TAG    RELEASE_0.9.4
ENV SLIMERJS_GIT_URL    https://github.com/laurentj/slimerjs.git
ENV CASPERJS_GIT_TAG    1.1-beta3
ENV CASPERJS_GIT_URL    https://github.com/n1k0/casperjs.git

# Install
COPY install.sh /
RUN bash -xe /install.sh


# Default command
CMD ["/usr/bin/slimerjs"]
