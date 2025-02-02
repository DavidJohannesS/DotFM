#!/bin/bash

server_pubkey="$1"
# Get server public key as an argument
if [ -z "$1" ] 
then

    read -p "Enter the server's public key: " server_pubkey
fi

read -p "Enter Peer's IP (e.g., 10.0.0.2/32): " peer_ip
# Prompt for configuration file name
read -p "Enter the desired configuration file name (e.g., wg0.conf): " conf_name

# Prompt for endpoint address
read -p "Enter the endpoint address (e.g., mydomain.ddns.net:51820): " endpoint

# Prompt for allowed IPs
read -p "Enter allowed IPs (e.g., 0.0.0.0/0): " allowed_ips

# Prompt for MTU size
read -p "Enter MTU size (e.g., 1420): " mtu

# Generate the private key
private_key=$(wg genkey)

# Create the WireGuard configuration file
cat <<EOF > "$conf_name"
[Interface]
PrivateKey = $private_key
Address = $peer_ip 
DNS = 9.9.9.9

[Peer]
PublicKey = $server_pubkey
AllowedIPs = $allowed_ips
Endpoint = $endpoint
PersistentKeepalive = 25
MTU = $mtu
EOF

# Output the private key to a file
echo "Your private key is:"
echo "$private_key"
echo "$private_key" > "$conf_name.pem"

echo "WireGuard configuration file '$conf_name' created successfully."
