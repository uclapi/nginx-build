FROM ubuntu:18.04

#################################
#### Control versioning here ####
#################################
ENV NGINX_VERSION 1.16.0

#################################
####### The build process #######
#################################

# Install required packages to build Nginx
RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get -y install build-essential \
                       wget \
                       curl \
                       git \
                       libgeoip1 \
                       libgeoip-dev \
                       libgnutls-openssl27 \
                       libgnutls30 \
                       libssl-dev \
                       zlib1g \
                       zlib1g-dev\
                       libpcre3 \
                       libpcre3-dev \
                       geoip-bin \
                       geoip-database \
                       sed \
                       libtool \
                       m4 \
                       autogen \
                       automake \
                       libevent-dev \
                       pkg-config && \
    apt-get clean

# Download and extract the Nginx code, and check out the two plugins we need
RUN wget -O - "https://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz" | tar zxvf - && \
    git clone https://github.com/nginx-shib/nginx-http-shibboleth.git http-shib && \
    git clone https://github.com/openresty/headers-more-nginx-module.git headers-more

WORKDIR nginx-${NGINX_VERSION}
RUN ./configure --with-http_ssl_module \
                --with-http_realip_module \
                --with-http_geoip_module \
                --add-module=../http-shib/ \
                --add-module=../headers-more \
                --without-mail_pop3_module \
                --without-mail_imap_module \
                --without-mail_smtp_module \
                --with-http_gzip_static_module
RUN make -j4 && make install

WORKDIR /usr/local/nginx

RUN tar czvf /etc/nginx-build.tar.gz ./*

WORKDIR /

COPY ./get_build.sh /etc/get_build.sh
RUN chmod +x /etc/get_build.sh

RUN echo "Build completed! Output stored at /etc/nginx-build.tar.gz"

CMD /etc/get_build.sh
