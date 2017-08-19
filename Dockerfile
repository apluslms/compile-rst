FROM apluslms/run-python3

WORKDIR /compile

RUN pip3 install sphinx pyyaml
