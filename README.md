# Testing instructions
- Run `./build.sh` the below command to build the image and run the nginx container.
- Notice that `id` returns the non-root user, but nginx is still able to listen to port 80. This is possible because `ip_unprivileged_port_start` is set to `0`, which enables non-root users to bind to any port, including privileged ports (ports below 1024). By default, only processes running as the root user can bind to privileged ports. This setting effectively removes the restriction, enabling non-root users to bind to these ports.

# Why is this useful?
**Security**: Running applications as a non-root user is a best practice for security. By setting `ip_unprivileged_port_start=0`, you can allow a non-root user to bind to privileged ports (e.g., port 80 for HTTP) without granting root privileges.

**Simplifies Configuration**: Without this setting, you would need to:
- Use a reverse proxy or port forwarding to map privileged ports to higher ports.
- Grant specific capabilities (e.g. `CAP_NET_BIND_SERVICE`) to the application binary.
