FROM mono:4.2

WORKDIR /klondike

RUN apt-get update && \
    apt-get install --no-install-recommends -y git \
    cron \
    python \
    python-pip && \
    rm -rf /var/cache/apt/*

RUN pip install -U setuptools && \
    pip install awscli

RUN git clone https://github.com/themotleyfool/Klondike-Release .

COPY Settings.config /klondike/Settings.config
COPY run-klondike.sh /usr/local/bin/run-klondike.sh
COPY s3-sync.sh /usr/local/bin/s3-sync.sh

RUN chmod +x /usr/local/bin/run-klondike.sh && chmod +x /usr/local/bin/s3-sync.sh

EXPOSE 8080
VOLUME /klondike/data

CMD ["/usr/local/bin/run-klondike.sh"]