set -o pipefail

# add a never version of git
echo "deb http://ppa.launchpad.net/git-core/ppa/ubuntu trusty main" > /etc/apt/sources.list.d/git-core.list;
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E1DF1F24

apt-get update
apt-get upgrade -qqy
apt-get install -qqy git
apt-get install -qqy --no-install-recommends firefox-dev python xvfb libxrender-dev libasound2 libdbus-glib-1-2 libgtk2.0-0

mkdir -p /srv/var/

# slimerjs

git clone --branch ${SLIMERJS_GIT_TAG} --depth 1 ${SLIMERJS_GIT_URL} /srv/var/slimerjs
rm -rf !$/.git

cat <<\EOF > /srv/var/slimerjs/slimerjs.sh
#!/usr/bin/env bash
xvfb-run /srv/var/slimerjs/src/slimerjs $*
EOF
chmod 755 /srv/var/slimerjs/slimerjs.sh
ln -s /srv/var/slimerjs/slimerjs.sh /usr/bin/slimerjs


# casperjs
git clone --branch ${CASPERJS_GIT_TAG} --depth 1 ${CASPERJS_GIT_URL} /srv/var/casperjs
rm -rf !$/.git

cat <<\EOF > /srv/var/casperjs/casperjs.sh
#!/usr/bin/env bash
/srv/var/casperjs/bin/casperjs --engine=slimerjs $*
EOF
chmod 755 /srv/var/casperjs/casperjs.sh
ln -s /srv/var/casperjs/casperjs.sh /usr/bin/casperjs


# clean up
apt-get purge -y --auto-remove git
apt-get autoremove -qqy
apt-get clean all
rm -rf /var/lib/apt/lists/*
