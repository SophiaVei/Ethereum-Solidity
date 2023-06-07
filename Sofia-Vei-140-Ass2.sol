// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CharityDonation {
    // Array to store the addresses of charities
    address[] public charities;

    // Address of the contract owner
    address public owner;

    // Total amount of donations received by the contract
    uint256 public totalDonations;

    // Address of the highest donor
    address public highestDonor;

    // Highest donation amount received
    uint256 public highestDonation;

    // Modifier to restrict access to functions only to the contract owner
    modifier onlyOwner() {
        require(msg.sender == owner, "Only contract owner can call this function");
        _;
    }

    // Constructor that accepts an array of charity addresses at contract deployment
    constructor(address[] memory _charities) {
        charities = _charities;
        owner = msg.sender;
    }

    // Function for making a donation to a specified charity and destination address
    // Without the donation amount parameter - serves as a simplified version of the donation method
    // Basic implementation of the donation functionality. Check later on in the code for overloading method
    function donate(address destination, uint256 charityIndex) public payable {
        // Check if the charity index is valid
        require(charityIndex < charities.length, "Invalid charity index");

        // Check if the donation amount is greater than 0
        require(msg.value > 0, "Donation amount must be greater than 0");

        // Calculate the donation amount, charity amount, and destination amount
        uint256 donationAmount = msg.value;
        uint256 charityAmount = donationAmount / 10;
        uint256 destinationAmount = donationAmount - charityAmount;

        // Transfer the charity amount to the specified charity
        payable(charities[charityIndex]).transfer(charityAmount);

        // Transfer the destination amount to the specified destination address
        payable(destination).transfer(destinationAmount);

        // Update the total donations
        totalDonations += donationAmount;

        // Check if the current donation is the highest so far
        if (msg.value > highestDonation) {
            highestDonation = msg.value;
            highestDonor = msg.sender;
        }

        // Emit an event to indicate the donation
        emit Donation(msg.sender, msg.value);
    }

    // Overloaded version of the donate method that accepts a donation amount
    // This function implements method overloadingon to a specified charity and destination address with a specific donation amount
    function donate(address destination, uint256 charityIndex, uint256 donationAmount) public payable {
        // Check if the donation amount is within acceptable limits
        require(donationAmount >= totalDonations / 100, "Donation amount is below minimum");
        require(donationAmount <= totalDonations / 2, "Donation amount exceeds maximum");

        // Check if the charity index is valid
        require(charityIndex < charities.length, "Invalid charity index");

        // Check if the sent value matches the specified donation amount
        require(msg.value == donationAmount, "Donation amount must match the sent value");

        // Calculate the charity amount and destination amount
        uint256 charityAmount = donationAmount / 10;
        uint256 destinationAmount = donationAmount - charityAmount;

        // Transfer the charity amount to the specified charity
        payable(charities[charityIndex]).transfer(charityAmount);

        // Transfer the destination amount to the specified destination address
        payable(destination).transfer(destinationAmount);

        // Update the total donations
        totalDonations += donationAmount;

        // Check if the current donation is the highest so far
        if (msg.value > highestDonation) {
            highestDonation = msg.value;
            highestDonor = msg.sender;
        }

        // Emit an event to indicate the donation
        emit Donation(msg.sender, msg.value);
    }

    // Function to retrieve the total amount of donations received
        function getTotalDonations() public view returns (uint256) {
        return totalDonations;
    }

    // Function to retrieve the address and amount of the highest donor
    function getHighestDonor() public view onlyOwner returns (address, uint256) {
        return (highestDonor, highestDonation);
    }

    // Function to destroy the contract and transfer its balance to the contract owner
    function destroy() public onlyOwner {
        payable(owner).transfer(address(this).balance);
    }

    // Event to emit when a donation is made
    event Donation(address indexed donor, uint256 amount);
}

// Note: the use of selfdestruct was only avoided because solidity by default raises a warning for it, which is also mentioned in the documentation https://docs.soliditylang.org/en/v0.8.20/solidity-by-example.html
// However, just to have an insight, it would be used like this: 
// //Function to destroy the contract and transfer its balance to the contract owner
// function destroy() public onlyOwner {
//     selfdestruct(payable(owner));
//}