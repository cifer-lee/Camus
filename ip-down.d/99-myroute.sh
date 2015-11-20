#!/bin/sh
export PATH="/bin:/sbin:/usr/sbin:/usr/bin"

priv_route=$(cat /tmp/priv_route)

priv_gw=$(echo "$priv_route" | cut -d ' ' -f 1)
priv_iface=$(echo "$priv_route" | cut -d ' ' -f 2)

# Replace the default route
ip route del default via $5 dev $1

# For Green VPN and Github users:
#
# Green VPN blocks the tcp 22 port for security concern, which results in
# not being unable to do push & fetch operations if using git:// schema
#
# This IP range is according to link:
# https://help.github.com/articles/what-ip-addresses-does-github-use-that-i-should-whitelist/
ip route del 192.30.252.0/22 via $priv_gw dev $priv_iface

# For Green VPN and Bitbucket users:
#
# Green VPN blocks the tcp 22 port for security concern, which results in
# not being unable to do push & fetch operations if using git:// schema
#
# This IP range is according to link:
# https://confluence.atlassian.com/display/BITBUCKET/What+are+the+Bitbucket+IP+addresses+I+should+use+to+configure+my+corporate+firewall
ip route del 131.103.20.167/32 via $priv_gw dev $priv_iface
ip route del 131.103.20.168/31 via $priv_gw dev $priv_iface
ip route del 131.103.20.170/32 via $priv_gw dev $priv_iface
