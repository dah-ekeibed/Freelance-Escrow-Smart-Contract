# Freelance Escrow Smart Contract

This is a **Solidity-based escrow smart contract** designed to facilitate **secure freelance transactions**. It helps clients and freelancers handle payments safely, releasing funds only when work is confirmed.

## Features:
- Client deposits funds into the escrow contract.
- Freelancer is notified and begins work.
- Client can confirm work completion, releasing funds to the freelancer.
- In case of disputes, both parties can raise a dispute, and the contract can resolve it by releasing funds to the winner.

## How It Works:
1. **Deploy the contract** with the freelancer's Ethereum address.
2. **Client deposits funds** into the escrow contract.
3. **Freelancer completes work** and confirms completion.
4. **Client confirms the work**, and funds are released to the freelancer.
5. **Raise a dispute** if there’s any disagreement between client and freelancer.

## How to Use:
1. Clone this repository.
2. Deploy the `FreelanceEscrow.sol` contract on the Ethereum network.
3. Interact with the contract using a **Web3** interface or tools like **Remix** or **Truffle**.

## Example Deployment

Here is an example of how to deploy the contract on **Remix IDE**:
1. Go to [Remix](https://remix.ethereum.org/).
2. Open the `FreelanceEscrow.sol` file.
3. Compile and deploy the contract.

## Dispute Resolution
In case of a disagreement, both the client and freelancer can raise a dispute. The contract will require the **winner** to be selected, and the funds will be transferred accordingly.

## License
This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.

