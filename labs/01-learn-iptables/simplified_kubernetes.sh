# Create two instances using multipass
multipass launch -n simple-k8s-1 --network Wi-Fi
multipass launch -n simple-k8s-2 --network Wi-Fi


# Create a network namespace inside simple-k8s-1 to simulate a container
ip netns add container1
ip link add netns container1 name veth0 type veth peer name veth1

ip addr add 10.3.1.1/16 dev veth1
ip netns exec container1 ip addr add 10.3.1.2/16 dev veth0

ip link set dev veth1 up
ip netns exec container1 ip link set dev veth0 up
ip netns exec container1 ip link set dev lo up


# Create a network namespace inside simple-k8s-2 to simulate a container
ip netns add container2
ip link add netns container2 name veth0 type veth peer name veth1

ip addr add 10.3.2.1/16 dev veth1
ip netns exec container2 ip addr add 10.3.2.2/16 dev veth0

ip link set dev veth1 up
ip netns exec container2 ip link set dev veth0 up
ip netns exec container2 ip link set dev lo up


# Create vxlan on simple-k8s-1
ip link add vxlan100 type vxlan id 100 dstport 4789 local 10.0.1.79 remote 10.0.1.80 dev enp0s8

ip link add br0 type bridge

ip link set veth1 master br0
ip link set vxlan100 master br0

ip link set br0 up
ip link set vxlan100 up


# Create vxlan on simple-k8s-2
ip link add vxlan100 type vxlan id 100 dstport 4789 local 10.0.1.80 remote 10.0.1.79 dev enp0s8

ip link add br0 type bridge

ip link set veth1 master br0
ip link set vxlan100 master br0

ip link set br0 up
ip link set vxlan100 up


# on simple-k8s-1
ip netns exec container1 python3 -m http.server

# on simple-k8s-2
ip netns exec container2 curl 10.3.1.2:8000
