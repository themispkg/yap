FROM debian

COPY . /app/yap
WORKDIR /app/yap
RUN apt update && apt install -y make git gcc tar
RUN make install
WORKDIR ~
ENTRYPOINT /bin/bash
