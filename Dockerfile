FROM ubuntu:18.04

ENV LANG=C.UTF-8

RUN apt-get update -qqy && DEBIAN_FRONTEND=noninteractive apt-get install -qqy --no-install-recommends \
    -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" \
    apt-utils \
    ca-certificates \
    make \
    python3.6 \
    python3-pip \
    python3-setuptools \
    zip \
  && rm -rf /var/lib/apt/lists/* /var/cache/apt/* \
  && pip3 install --no-cache-dir --disable-pip-version-check \
    "docutils~=0.16.0" \
    "sphinx~=1.6.7" \
    "recommonmark~=0.7.1" \
    "PyYAML~=5.4.1" \
    Unidecode \
    regex \
  && rm -rf /root/.cache

COPY dummy_git.sh /usr/local/bin/git
COPY legacy_build.sh /usr/local/bin/legacy_build

WORKDIR /compile
VOLUME /compile

CMD ["make"]
