# iptables Exercises: From Basic to Advanced

This lab contains a series of exercises to test your knowledge of `iptables`. 
**Note:** These exercises should be performed in a safe, isolated Linux environment (like a VM or network namespace) as they can disrupt network connectivity.

---

### Level 1: The Basics
1. **Inventory:** List all current rules in all tables (filter, nat, mangle) with line numbers and verbose output.
2. **Clean Slate:** Write the commands to flush all rules, delete all custom chains, and set the default policy for `INPUT`, `FORWARD`, and `OUTPUT` to `ACCEPT`.
3. **The Lockdown:** Change the default policy for the `INPUT` chain to `DROP`. What happens to your current connections?

### Level 2: Simple Filtering
4. **Localhost First:** Allow all traffic on the loopback interface. Why is this usually the first rule in a production script?
5. **Selective SSH:** Allow incoming SSH traffic (port 22) but **only** from the IP address `192.168.1.50`.
6. **Ping Control:** Block all incoming ICMP "echo-request" (ping) messages from the subnet `10.0.0.0/24`, but allow them from any other source.

### Level 3: Stateful & Service Filtering
7. **Stateful Firewall:** Configure the `INPUT` chain to allow only packets that are part of an `ESTABLISHED` or `RELATED` connection.
8. **Web Server:** Allow incoming TCP traffic on ports 80 (HTTP) and 443 (HTTPS) for any source, ensuring only "NEW" connections are accepted (leveraging the stateful rule from exercise 7).

### Level 4: Advanced Logic & Logging
9. **Custom Chains:** Create a custom chain named `LOG_AND_DROP`. Configure it to log packets with the prefix "IPT-REJECTED: " (limited to 5 entries per minute) and then drop the packet. Redirect all rejected traffic from the `INPUT` chain to this new chain.
10. **Port Redirect:** Redirect all incoming traffic destined for port 8080 to port 80 internally using the `PREROUTING` chain in the `nat` table.

### Level 5: The "Expert" Challenges
11. **Brute Force Protection:** Implement a rule that limits incoming SSH connections to a maximum of 3 attempts per minute per source IP. Packets exceeding this should be dropped.
12. **String Matching:** (Requires `xt_string` module) Block any incoming HTTP request that contains the literal string "DEBUG_ADMIN" in the payload.
13. **Time-Based Access:** Allow access to a specific service (e.g., port 8888) only during "office hours" (Monday to Friday, 09:00 to 17:00).
