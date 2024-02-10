#!/bin/bash

# Remove HY2 if it's installed (optional)
bash <(curl -fsSL https://raw.githubusercontent.com/xyazzrany/hy2-vps-install/main/remove.sh)

# Install HY2
bash <(curl -fsSL https://get.hy2.sh)

# Enable hysteria-server.service
systemctl enable hysteria-server.service

# Configure HY2
cat << EOF > /etc/hysteria/config.yaml
listen: :8443 # Listening port

# Using CA certificate
#acme:
#  domains:
#    - a.com # Your domain name, needs to be resolved to server IP first
#  email: test@sharklasers.com

# Using self-signed certificate
#tls:
#  cert: /etc/hysteria/server.crt
#  key: /etc/hysteria/server.key

auth:
  type: password
  password: 123456 # Set authentication password
  
masquerade:
  type: proxy
  proxy:
    url: https://bing.com # Masquerade URL
    rewriteHost: true
EOF

# Restart hysteria-server.service
systemctl restart hysteria-server.service
