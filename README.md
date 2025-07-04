# Noir Weighted Voting Circuit

## Overview

This repository demonstrates how to write, prove, and verify a zero-knowledge circuit in Noir that computes a **weighted sum** of private inputs.  
It uses the `bb` backend to generate proofs and a Solidity verifier to enable on-chain verification.

The project also showcases how to integrate Noir-generated proofs with Ethereum smart contracts using both JavaScript and CLI-based workflows.


---

## ✨ Introduction

An example repo to verify Noir circuits using:
- **Noir (v1.0.0-beta.6)** — to define and compile the circuit.
- **bb (v0.84.0)** — as the backend to generate the proof.
- **Solidity** — for on-chain verification of the proof.
- **JavaScript** — to orchestrate proof generation and export.

### Folder Structure:
- `/circuits` – Contains the Noir circuits.
- `/contract` – A Foundry project with:
  - A Solidity verifier contract.
  - A test contract that reads the proof file and verifies it.
- `/js` – JavaScript scripts to:
  - Generate proofs.
  - Save them as JSON files compatible with Solidity.

---

## 🧠 Circuit Logic

The Noir circuit enforces the relation:

\[
\sum_{i=0}^{4} (\texttt{votes}[i] \times \texttt{weights}[i]) = \texttt{public\_total}
\]

This ensures the weighted sum of votes matches the publicly claimed total.



Where:
- `votes`: an array of **private** inputs representing individual votes.
- `weights`: an array of **private** inputs representing each vote's weight.
- `public_total`: a **public** value representing the final weighted total that must match the private computation.


This is a minimal example to illustrate how to prove knowledge of a private input involved in a linear arithmetic constraint and verify it on-chain.

---

## ✅ Tested With
- **Noir**: `v1.0.0-beta.6`
- **bb**: `v0.84.0`

## 🛠 Installation & Setup

```bash
# Clone the repo and pull submodules (e.g., for bb-solidity)
git submodule update --init --recursive

# Build circuits and generate the Solidity verifier
(cd circuits && ./build.sh)

# Install JavaScript dependencies
(cd js && yarn)
``` 

## 🧪 Proof Generation (JavaScript Workflow)

```bash
# Use bb.js to generate proof and save it to a file
(cd js && yarn generate-proof)

# Run Foundry test to read the generated proof and verify it
(cd contract && forge test --optimize --optimizer-runs 5000 --gas-report -vvv)
```
## 🔧 Proof Generation (CLI Workflow)

```bash
cd circuits

# Generate witness using nargo
nargo execute

# Generate proof with bb CLI
bb prove -b ./target/noir_weighted_voting_circuit.json -w ./target/noir_weighted_voting_circuit.gz -o ./target --oracle_hash keccak

# Run Foundry test to verify proof
cd ..
(cd contract && forge test --optimize --optimizer-runs 5000 --gas-report -vvv)
```

## 🔁 Dual Workflow Support: CLI & JavaScript

This project supports two parallel workflows for generating and verifying proofs:

- ✅ **JavaScript-based workflow** using `bb.js` and automated proof orchestration
- 🔧 **Command-line workflow** using `nargo` and `bb` directly

Choose the one that fits your stack or integration best.

---

## 🏗️ Building the Solidity Verifier

Run the `build.sh` script from the project root:

```bash
./build.sh
```
This will:
- Compile the Noir circuit using `nargo`
- Generate the verification key (`vk`)
- Export the Solidity verifier as `contract/Verifier.sol`





