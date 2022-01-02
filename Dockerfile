FROM debian:latest

ARG pyver=3.10.1

# Updating and installing required packages
WORKDIR /
RUN apt update -y
RUN apt upgrade -y
RUN apt install wget build-essential libncursesw5-dev libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev libffi-dev zlib1g-dev -y

# Downloading and extracting Python
WORKDIR /usr/src/
RUN mkdir python
WORKDIR /usr/src/python
RUN wget https://www.python.org/ftp/python/${pyver}/Python-${pyver}.tgz
RUN tar -xf Python-${pyver}.tgz

# Building Python
WORKDIR /usr/src/python/Python-${pyver}
RUN ./configure --enable-optimizations
RUN make
RUN make install

WORKDIR /

# Linking pip3 to pip
RUN ln -s /usr/local/bin/pip3 /usr/local/bin/pip
# Linking python3 to python
RUN ln -s /usr/local/bin/python3 /usr/local/bin/python