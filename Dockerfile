FROM apluslms/run-python3

RUN pip3 install sphinx pyyaml

WORKDIR /compile
VOLUME /compile

CMD ["make"]

