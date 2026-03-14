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


