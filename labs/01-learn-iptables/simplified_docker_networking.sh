# Create namespace
ip netns add simple-docker

# Create veth pair
ip link add veth_host type veth peer name veth_ns


# Setup host end of the veth
ip addr add 10.0.0.1/24 dev veth_host
ip link set veth_host up


# Setup ns end of the veth
ip link set veth_ns netns simple-docker
ip netns exec simple-docker ip addr add 10.0.0.2/24 dev veth_ns
ip netns exec simple-docker ip link set lo up
ip netns exec simple-docker ip link set veth_ns up
ip netns exec simple-docker ip route add default via 10.0.0.1

# List interfaces in namespace
ip netns exec simple-docker ip -br a


# Enable forwarding
sysctl -w net.ipv4.ip_forward=1


# Configure NAT (for internet access from inside the namespace)
iptables -t nat -A POSTROUTING -s 10.0.0.1/24 -o eth0 -j MASQUERADE

# Configure that traffic from the internet can reach the simple-docker namespace
iptables -A FORWARD -i eth0 -o veth_host -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -i veth_host -o eth0 -j ACCEPT


# Verify we can reach internet through namespace
ip netns exec simple-docker ping 8.8.8.8
