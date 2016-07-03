
job "loadbalancer" {
    # Run on EVERY client node
    type = "system"
    datacenters = [ "dc1" ]
    group "loadbalancer" {
        count = 1
        task "loadbalancer" {
            driver = "docker"
            config {
                image = "registry.service.consul/loadbalancer"
                network_mode = "host"
            }
            resources {
                memory = 256
                network {
                    mbits = 1
                    port "web" {
                        static = 80
                    }
                }
            }
        }
    }
}
