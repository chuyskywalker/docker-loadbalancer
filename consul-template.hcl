template {
  source          = "/etc/nginx/nginx.conf.ctmpl"
  destination     = "/etc/nginx/nginx.conf"
  command         = "nginx -s reload"
  command_timeout = "60s"
}