FROM --platform=linux/amd64 ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive


RUN apt update -y && apt install -y \
    openssh-server \
    sudo \
    vim \
    net-tools \
    curl \
    wget \
    git \
    tzdata \
    && rm -rf /var/lib/apt/lists/*


WORKDIR /root/pro

RUN mkdir /var/run/sshd

RUN echo "root:echo77" | chpasswd

RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

EXPOSE 22


CMD ["/usr/sbin/sshd", "-D"]
