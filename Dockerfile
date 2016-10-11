FROM alpine:3.3

RUN apk add --no-cache alpine-sdk wget pcre-dev openssl-dev ffmpeg
RUN wget http://nginx.org/download/nginx-1.10.1.tar.gz && tar -zxvf nginx-1.10.1.tar.gz 
RUN wget https://github.com/sergey-dryabzhinsky/nginx-rtmp-module/archive/master.zip && unzip master.zip
WORKDIR /nginx-1.10.1
RUN ./configure --with-http_ssl_module --with-http_stub_status_module --add-module=../nginx-rtmp-module-master && make && sudo make install
RUN mkdir -p /HLS/live && mkdir -p /HLS/mobile && mkdir /recordings
RUN mkdir -p /var/log/nginx
COPY nginx.conf /usr/local/nginx/conf/nginx.conf
ENTRYPOINT ["sudo", "/usr/local/nginx/sbin/nginx", "-g", "daemon off;"]