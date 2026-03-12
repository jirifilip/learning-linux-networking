#!/bin/bash

# ==============================================================================
# iptables Playground: Safe Isolation via Network Namespaces
# This script creates an isolated network environment for practicing iptables.
# ==============================================================================

NS_NAME="iptables-lab"

# Ensure the script is run as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root (use sudo)."
  exit 1
fi

# Cleanup function
cleanup() {
    echo ""
    echo "[*] Cleaning up namespace: $NS_NAME..."
    ip netns del $NS_NAME 2>/dev/null
}

# Ensure clean start
ip netns del $NS_NAME 2>/dev/null

echo "[*] Creating network namespace: $NS_NAME..."
ip netns add $NS_NAME

# Bring up the loopback interface inside the namespace
echo "[*] Bringing up loopback interface..."
ip netns exec $NS_NAME ip link set lo up

echo "----------------------------------------------------------"
echo " WELCOME TO THE IPTABLES PLAYGROUND"
echo "----------------------------------------------------------"
echo " You are now entering an ISOLATED shell."
echo " Commands you run here will NOT affect your host or WSL."
echo " To exit the playground, type 'exit'."
echo "----------------------------------------------------------"

# Drop the user into a bash shell inside the namespace
ip netns exec $NS_NAME bash --rcfile <(echo "PS1='(iptables-playground) \u@\h:\w\$ '")

# Run cleanup after the user exits the shell
cleanup
