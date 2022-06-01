#!/bin/bash
# https://gist.github.com/robinlandstrom/b111240cd74ecab4d358f28b2d4fd8de

readonly INTERFACE="server"

# Generate peer keys
readonly PRIVATE_KEY=$(wg genkey)
readonly PUBLIC_KEY=$(echo ${PRIVATE_KEY} | wg pubkey)
readonly PRESHARED_KEY=$(wg genpsk)

# Read server key from interface
readonly SERVER_PUBLIC_KEY=$(wg show ${INTERFACE} public-key)

# Get next free peer IP (This will break after x.x.x.255)
readonly PEER_ADDRESS=$(wg show ${INTERFACE} allowed-ips | cut -f 2 | awk -F'[./]' '{print $1"."$2"."$3"."1+$4"/"$5}' | sort -t '.' -k 1,1 -k 2,2 -k 3,3 -k 4,4 -n | tail -n1)

# Add peer
wg set ${INTERFACE} peer ${PUBLIC_KEY} preshared-key <(echo ${PRESHARED_KEY}) allowed-ips ${PEER_ADDRESS}

# Store peer config
cat << END_OF_CONFIG | tee /etc/wireguard/clients/$0.conf
[Interface]
Address = ${PEER_ADDRESS}
PrivateKey = ${PRIVATE_KEY}

[Peer]
PublicKey = ${SERVER_PUBLIC_KEY}
PresharedKey = ${PRESHARED_KEY}
AllowedIPs = 10.0.0.0/24
Endpoint = tandyserver.duckdns.org:57576
END_OF_CONFIG
