FROM mono:4.2

WORKDIR /klondike

RUN apt-get update && \
    apt-get install git -y && \
    rm -rf /var/cache/apt/*

RUN git clone https://github.com/themotleyfool/Klondike-Release .
COPY Settings.config /klondike/Settings.config

EXPOSE 8080
VOLUME /klondike/data

CMD ["mono", "./bin/Klondike.SelfHost.exe", "--interactive", "--port=8080"]
