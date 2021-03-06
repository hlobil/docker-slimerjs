# set -o pipefail



apt-get update
apt-get upgrade -qqy
apt-get install -qqy wget bzip2
apt-get install -qqy --no-install-recommends python xvfb libxrender-dev libasound2 libdbus-glib-1-2 libgtk2.0-0
#


# slimerjs
mkdir -p /srv/var/slimerjs
wget -qO- http://download.slimerjs.org/releases/$SLIMERJS_VER/slimerjs-$SLIMERJS_VER-linux-x86_64.tar.bz2 \
  | tar -C /srv/var/slimerjs --strip-components=1 -xj > /dev/null
cat <<\EOF > /srv/var/slimerjs/slimerjs.sh
#!/usr/bin/env bash
xvfb-run /srv/var/slimerjs/slimerjs $*
EOF
chmod 755 /srv/var/slimerjs/slimerjs.sh
ln -s /srv/var/slimerjs/slimerjs.sh /usr/bin/slimerjs


# casperjs
mkdir -p /srv/var/casperjs
wget -qO- https://github.com/n1k0/casperjs/tarball/master \
  | tar -C /srv/var/casperjs --strip-components=1 -xzv
cat <<\EOF > /srv/var/casperjs/casperjs.sh
#!/usr/bin/env bash
/srv/var/casperjs/bin/casperjs --engine=slimerjs $*
EOF
chmod 755 /srv/var/casperjs/casperjs.sh
ln -s /srv/var/casperjs/casperjs.sh /usr/bin/casperjs


# clean up
apt-get purge -y --auto-remove git wget bzip2
rm -rf /var/lib/apt/lists/*
apt-get autoremove -qqy
apt-get clean all
