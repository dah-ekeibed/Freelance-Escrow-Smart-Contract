// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract FreelanceEscrow {

    // State variables
    address public client;
    address public freelancer;
    uint public escrowAmount;
    bool public workCompleted;
    bool public disputeRaised;

    enum State { Pending, Completed, Disputed, Resolved }
    State public contractState;

    // Event declarations
    event FundsDeposited(address indexed client, uint amount);
    event WorkConfirmed(address indexed client);
    event FundsReleased(address indexed freelancer, uint amount);
    event DisputeRaised(address indexed client);
    event DisputeResolved(address indexed winner);

    // Constructor: Initializes the contract with the freelancer's address
    constructor(address _freelancer) {
        client = msg.sender; // The one deploying the contract is the client
        freelancer = _freelancer;
        contractState = State.Pending;  // Initial state is Pending
    }

    // Function to deposit funds into the escrow contract
    function deposit() external payable {
        require(msg.sender == client, "Only client can deposit funds.");
        require(contractState == State.Pending, "Contract is no longer in pending state.");
        
        escrowAmount = msg.value; // Store the deposited amount
        emit FundsDeposited(client, escrowAmount);
    }

    // Function to confirm the completion of the work by the client
    function confirmWork() external {
        require(msg.sender == client, "Only client can confirm the work.");
        require(contractState == State.Pending, "Contract is not pending.");

        workCompleted = true; // Work has been completed
        contractState = State.Completed; // Update contract state to Completed
        status = "Completed";  // Update status

        // Release funds to freelancer
        payable(freelancer).transfer(escrowAmount);
        emit WorkConfirmed(client);
        emit FundsReleased(freelancer, escrowAmount);
    }

    // Function to raise a dispute (in case of disagreement between parties)
    function raiseDispute() external {
        require(msg.sender == client || msg.sender == freelancer, "Only client or freelancer can raise dispute.");
        require(contractState == State.Pending, "Dispute can only be raised in pending state.");

        disputeRaised = true;  // Mark that a dispute is raised
        contractState = State.Disputed; // Update contract state to Disputed
        status = "Disputed"; // Update status
        emit DisputeRaised(client);
    }

    // Function to resolve the dispute and release funds accordingly
    function resolveDispute(address winner) external {
        require(contractState == State.Disputed, "Dispute has not been raised.");
        require(msg.sender == client || msg.sender == freelancer, "Only client or freelancer can resolve the dispute.");
        require(winner == client || winner == freelancer, "Invalid winner.");

        // Resolve the dispute and release funds to the winner
        if (winner == client) {
            payable(client).transfer(escrowAmount);  // Refund client if they win
        } else if (winner == freelancer) {
            payable(freelancer).transfer(escrowAmount);  // Send funds to freelancer if they win
        }

        contractState = State.Resolved;  // Mark the contract as resolved
        status = "Resolved";  // Update status
        emit DisputeResolved(winner);
    }

    // View function to check the current status of the contract
    function getStatus() external view returns (string memory) {
        if (contractState == State.Pending) {
            return "Pending";
        } else if (contractState == State.Completed) {
            return "Completed";
        } else if (contractState == State.Disputed) {
            return "Disputed";
        } else {
            return "Resolved";
        }
    }
}
