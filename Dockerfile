FROM redhat/ubi8

# Install necessary packages including sudo and net-tools
RUN dnf install -y nginx procps-ng libcap sudo net-tools

RUN echo "<html><body><h1>Hello World!</h1><body></html>" > /usr/share/nginx/html/index.html && \
    sed -i "s/\/run\/nginx.pid/\/var\/tmp\/nginx.pid/" /etc/nginx/nginx.conf && \
    cat /etc/nginx/nginx.conf | grep listen

# Remove the direct sysctl call
# RUN sysctl net.ipv4.ip_unprivileged_port_start

USER 1001

CMD ["nginx", "-g", "error_log /tmp/nginx_error.log debug; daemon off;"]