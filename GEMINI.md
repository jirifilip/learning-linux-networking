# GEMINI.md - Project Context

## Project Overview
**learning-linux-networking** is a hands-on laboratory environment for practicing Linux networking concepts. The project focuses on core networking utilities and protocols, including `iptables`, `tcpdump`, and DNS.

- **Primary Technologies:** Shell scripting (Bash), Linux networking tools (`iptables`, `tcpdump`, `iproute2`).
- **Potential Technologies:** Python (inferred from `.gitignore` and project path).
- **Architecture:** Lab-based structure where each networking concept is explored in a dedicated directory under `labs/`.

## Directory Structure
- `labs/`: Contains individual networking labs.
  - `01-learn-iptables/`: Lab focused on firewall rules and packet filtering using `iptables`.
    - `EXERCISES.md`: A list of 13 progressively difficult iptables challenges.
    - `playground.sh`: A shell script to create a safe, isolated network namespace for practice.
    - `main.sh`: Placeholder for lab automation.
- `README.md`: Basic project introduction.
- `.gitignore`: Standard Python ignore rules.

## Building and Running
As this project consists of shell-based labs, there is no traditional build step.

### Safe Practice Environment (WSL/Linux)
To practice networking commands without affecting your host's connectivity, use the provided playground script:
```bash
cd labs/01-learn-iptables
chmod +x playground.sh
sudo ./playground.sh
```
This drops you into an isolated bash shell (`iptables-lab` namespace) where you can safely run `iptables` commands.

### Running a Lab
Alternatively, you can execute a main script directly (requires root/sudo):
```bash
cd labs/01-learn-iptables
chmod +x main.sh
sudo ./main.sh
```

## Development Conventions
- **Lab Isolation:** Each lab should be self-contained within its own directory in `labs/`.
- **Documentation:** Each lab should ideally contain comments or a local README explaining the networking concepts being practiced.
- **Consistency:** Use clear, descriptive names for lab directories (e.g., `02-tcpdump-analysis`).
