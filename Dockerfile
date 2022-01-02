FROM ubuntu:focal
MAINTAINER Dhiraj & Zubin

#Install essential packages
RUN apt-get update && sudo apt-get install -y build-essential python3-dev automake git flex bison libglib2.0-dev libpixman-1-dev python3-setuptools lld-11 llvm-11 llvm-11-dev clang-11 lld llvm llvm-dev

# Download and install AFLplusplus
RUN cd $HOME
RUN git clone https://github.com/AFLplusplus/AFLplusplus && cd AFLplusplus
ENV export LLVM_CONFIG=llvm-config-11
RUN make distrib
RUN sudo make install

# Export required environmental variables
ENV CC=afl-clang-lto
ENV CXX=afl-clang-lto++
ENV AFL_LLVM_LAF_ALL=1

VOLUME ["/output","/corpus"]
