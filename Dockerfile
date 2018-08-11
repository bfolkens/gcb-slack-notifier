FROM alpine

RUN apk add --no-cache curl bash git

COPY notify.sh /usr/local/bin/

WORKDIR /workspace

CMD /usr/local/bin/notify.sh
