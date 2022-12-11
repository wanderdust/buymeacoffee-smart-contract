// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract CoffeeContract {
    // Payable address can receive Ether
    address payable public owner;

    // Cofee object
    struct Coffee {
        address giver;
        string message;
        string name;
        uint256 timestamp;
    }
    // Array of Coffee objects
    Coffee[] coffee;

    // Payable constructor can receive Ether
    constructor() payable {
        owner = payable(msg.sender);
    }

    // Function to transfer Ether from this contract to address from input
    function transfer(
        uint256 _amount,
        string memory _message,
        string memory _name
    ) public payable {
        uint256 maxAmount = 0.005 ether;
        require(
            _amount <= maxAmount,
            "Don't send more than 0.005 Ether at a time!"
        );

        (bool success, ) = owner.call{value: _amount}("");
        require(success, "Failed to send Ether");

        coffee.push(Coffee(msg.sender, _message, _name, block.timestamp));

        // Withdraw all Ether from this contract to owner every time a coffee is bought
        withdrawAll();
    }

    // Function to get the balance of this contract
    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }

    // Function to get all coffee objects
    function getAllCoffee() public view returns (Coffee[] memory) {
        return coffee;
    }

    // Withdraw function to transfer Ether from this contract to owner
    function withdrawAll() public {
        require(msg.sender == owner, "Only owner can withdraw");
        (bool success, ) = owner.call{value: address(this).balance}("");
        require(success, "Failed to withdraw Ether");
    }
}
