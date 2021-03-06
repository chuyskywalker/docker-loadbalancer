
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
            }
            env {
                PASSWORD = "{password}"
            }
            resources {
                memory = 256
            }
        }
    }
}
