FROM chuyskywalker/centos7-dumbinit-supervisor

COPY nginx.repo /etc/yum.repos.d/

RUN yum -y install epel-release
RUN yum -y install nginx unzip wget iproute sshpass openssh-clients

RUN wget https://releases.hashicorp.com/consul/0.6.4/consul_0.6.4_linux_amd64.zip \
 && unzip consul_0.6.4_linux_amd64.zip \
 && rm -r consul_0.6.4_linux_amd64.zip \
 && mv consul /usr/bin/consul

RUN wget https://releases.hashicorp.com/consul-template/0.15.0/consul-template_0.15.0_linux_amd64.zip \
 && unzip consul-template_0.15.0_linux_amd64.zip \
 && rm -r consul-template_0.15.0_linux_amd64.zip \
 && mv consul-template /usr/bin/consul-template

RUN rm -f /config/supervisor/watcher.ini

# We don't need to service discover this one, it pushes itself to the router
COPY consul.ini           /config/supervisor/consul.ini
COPY consul.json          /config/consul.json

# Watch for service changes, reconfigure nginx
COPY consul-template.ini  /config/supervisor/consul-template.ini
COPY consul-template.hcl  /config/consul-template.hcl

# Run nginx
COPY nginx.ini            /config/supervisor/nginx.ini
COPY nginx.conf.ctmpl     /etc/nginx/nginx.conf.ctmpl
COPY nginx.conf.ctmpl     /etc/nginx/nginx.conf

# Keep your claim on the router, uh, routing!
COPY claim.ini            /config/supervisor/claim.ini
COPY claim.sh             /claim.sh
COPY cmd.sh               /cmd.sh
