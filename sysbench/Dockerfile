FROM ubuntu:xenial

RUN apt-get update

RUN apt-get -y install make automake libtool pkg-config libaio-dev git

# For MySQL support
RUN apt-get -y install libmysqlclient-dev libssl-dev

# For PostgreSQL support
RUN apt-get -y install libpq-dev
WORKDIR /root
RUN git clone https://github.com/akopytov/sysbench.git
RUN cd sysbench &&./autogen.sh && ./configure --with-mysql --with-pgsql && make -j && make install
RUN rm -rf /root/sysbench

CMD ["sysbench"]
