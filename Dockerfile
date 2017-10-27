FROM apluslms/run-python3

RUN pip3 install sphinx pyyaml \
  && rm -rf /root/.cache

WORKDIR /compile
VOLUME /compile

CMD ["make"]
