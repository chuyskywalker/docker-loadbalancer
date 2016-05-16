FROM nginx:1.7
MAINTAINER Shane Sveller <shane@bellycard.com>

RUN DEBIAN_FRONTEND=noninteractive \
    apt-get update -qq && \
    apt-get -y install curl runit unzip && \
    rm -rf /var/lib/apt/lists/*

ENV CT_URL https://releases.hashicorp.com/consul-template/0.14.0/consul-template_0.14.0_linux_amd64.zip
RUN curl -OL $CT_URL && unzip consul-template_0.14.0_linux_amd64.zip && mv consul-template /usr/local/bin

ADD nginx.service /etc/service/nginx/run
ADD consul-template.service /etc/service/consul-template/run

RUN rm -v /etc/nginx/nginx.conf
ADD nginx.conf /etc/nginx/nginx.conf

RUN rm -v /etc/nginx/conf.d/*
ADD app.conf /etc/consul-templates/app.conf

CMD ["/usr/bin/runsvdir", "/etc/service"]
