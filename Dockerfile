FROM --platform=$TARGETPLATFORM debian:trixie-slim

ENV LANG=C.UTF-8 \
    PIP_DISABLE_PIP_VERSION_CHECK=1 \
    PIP_NO_CACHE_DIR=1 \
    PIP_BREAK_SYSTEM_PACKAGES=1

RUN set -eux; \
    apt-get update; \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      ca-certificates \
      make \
      python3 \
      python3-pip \
      python3-setuptools \
      # add build deps to be safe for regex if no wheel is available:
      build-essential \
      python3-dev \
      zip \
    ; \
    rm -rf /var/lib/apt/lists/*

RUN pip3 install \
      "sphinx~=6.2.1" \
      "Unidecode==1.3.8" \
      "PyYAML~=6.0" \
      "regex==2024.5.15"

COPY dummy_git.sh /usr/local/bin/git
COPY legacy_build.sh /usr/local/bin/legacy_build

WORKDIR /compile
VOLUME ["/compile"]

CMD ["make"]
