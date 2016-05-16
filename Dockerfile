FROM nginx:1.7
MAINTAINER Shane Sveller <shane@bellycard.com>

RUN DEBIAN_FRONTEND=noninteractive \
    apt-get update -qq && \
    apt-get -y install curl runit && \
    rm -rf /var/lib/apt/lists/*

ENV CT_URL https://github.com/hashicorp/consul-template/archive/v0.14.0.tar.gz
RUN curl -L $CT_URL | tar -C /usr/local/bin --strip-components 1 -zxf -

ADD nginx.service /etc/service/nginx/run
ADD consul-template.service /etc/service/consul-template/run

RUN rm -v /etc/nginx/nginx.conf
ADD nginx.conf /etc/nginx/nginx.conf

RUN rm -v /etc/nginx/conf.d/*
ADD app.conf /etc/consul-templates/app.conf

CMD ["/usr/bin/runsvdir", "/etc/service"]
