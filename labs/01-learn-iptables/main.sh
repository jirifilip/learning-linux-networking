# List rules
iptables --table filter --list -v -n

# Create two network namespaces
ip netns add netns1
ip netns add netns2

# Create virtual ethernet cable connecting those two namespaces
ip link add veth0 type veth peer name veth1

# Move interfaces to corresponding namespaces
ip link set veth0 netns netns1
ip link set veth1 netns netns2

sudo ip link set veth0 up
sudo ip link set veth1 up

# Add IP addresses to the interfaces
ip addr add 10.1.1.1/24 dev veth0
ip addr add 10.1.1.2/24 dev veth1


ip netns exec netns1 ping 10.1.1.2
ip netns exec netns1 traceroute 10.1.1.2
