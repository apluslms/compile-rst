FROM debian:stretch-slim

ENV LANG=C.UTF-8

ARG APLUS_RST_VER=v1.0

RUN : \
# install debian packages
 && apt-get update -qqy \
 && DEBIAN_FRONTEND=noninteractive apt-get install -qqy --no-install-recommends \
    -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" \
    -o APT::Install-Recommends="false" -o APT::Install-Suggests="false" \
    ca-certificates \
    curl \
    make \
    python3 \
    python3-pip \
    python3-setuptools \
    python3-yaml \
 && rm -rf /var/lib/apt/lists/* /var/cache/apt/* \
\
# install python packages
 && pip3 install --no-cache-dir --disable-pip-version-check \
    "sphinx<1.7" \
    Unidecode \
 && rm -rf /root/.cache \
\
# install a-plus-rst-tools
 && mkdir /opt/a-plus-rst-tools \
 && ( cd /opt/a-plus-rst-tools \
   && curl -LSs https://github.com/Aalto-LeTech/a-plus-rst-tools/archive/$APLUS_RST_VER.tar.gz -o - \
    | tar -zx --strip-components=1 --wildcards '*.py' '*/theme/*' \
   && python3 -m compileall -q . \
 ) \
\
# clean
 && DEBIAN_FRONTEND=noninteractive apt-get purge -qqy --autoremove curl \
 && :

COPY rootfs /
WORKDIR /compile
CMD ["a-plus-rst-auto-build"]
