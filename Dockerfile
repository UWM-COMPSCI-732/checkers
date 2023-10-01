FROM alpine:3.17

LABEL maintainer="boyland@uwm.edu"
LABEL version="1.0.0"

RUN apk update \
  && apk add --no-cache bash make git ncurses \
  && apk add --no-cache ocaml-runtime

ARG PREFIX=/usr/checkers
ARG LIB="${PREFIX}/lib"
ARG BIN="${PREFIX}/bin"

RUN mkdir ${PREFIX} ${LIB} ${BIN}

WORKDIR "${LIB}"
COPY fulluntyped/f fulluntyped
COPY fulluntypedref/f fulluntypedref
COPY fullomega/f fullomega
COPY fullisorec/f fullisorec
COPY fullequirec/f fullequirec
COPY fullfomsubisorecref/f fullfomsubisorecref

WORKDIR "${BIN}"
RUN echo "#!/bin/bash" > fulluntyped
RUN echo "/usr/bin/ocamlrun ${LIB}/fulluntyped" '$@' >> fulluntyped


RUN find "${BIN}" -type f -print0 | xargs -0 chmod +x

ENV PATH="${BIN}:$PATH"

WORKDIR /root
