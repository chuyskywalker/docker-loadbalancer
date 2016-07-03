FROM chuyskywalker/centos7-dumbinit-supervisor

COPY nginx.repo /etc/yum.repos.d/

RUN yum install -y nginx \
 && yum install -y wget unzip \
\
 && wget https://releases.hashicorp.com/consul/0.6.4/consul_0.6.4_linux_amd64.zip \
 && unzip consul_0.6.4_linux_amd64.zip \
 && rm -r consul_0.6.4_linux_amd64.zip \
 && mv consul /usr/bin/consul \
\
 && wget https://releases.hashicorp.com/consul-template/0.15.0/consul-template_0.15.0_linux_amd64.zip \
 && unzip consul-template_0.15.0_linux_amd64.zip \
 && rm -r consul-template_0.15.0_linux_amd64.zip \
 && mv consul-template /usr/bin/consul-template \
\
 && yum -y history undo last \
 && rm -rf /var/cache/yum

RUN rm -f /config/supervisor/watcher.ini

COPY consul-template.ini  /config/supervisor/consul-template.ini
COPY consul.ini           /config/supervisor/consul.ini
COPY nginx.ini            /config/supervisor/nginx.ini

COPY consul-template.hcl  /config/consul-template.hcl
COPY consul.json          /config/consul.json
COPY nginx.conf.ctmpl     /etc/nginx/nginx.conf.ctmpl

# Put this one is bogusly
COPY nginx.conf.ctmpl     /etc/nginx/nginx.conf
