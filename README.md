# On-Chain Voting DAO

This repository contains a simple yet robust DAO (Decentralized Autonomous Organization) governance contract. It uses a token-weighted voting system where the more tokens you hold, the more influence your vote has.

## Governance Workflow
1. **Proposal:** An eligible member creates a proposal with a target address and data.
2. **Voting:** Members vote "Yes" or "No" during the voting period.
3. **Queue/Execute:** If the proposal passes (reaches quorum and majority), it can be executed to interact with other contracts.



## Key Parameters
* **Quorum:** The minimum percentage of total supply required to vote for a proposal to be valid.
* **Voting Period:** The duration (in blocks or seconds) that a proposal remains open for voting.
