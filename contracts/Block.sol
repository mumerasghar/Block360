//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract Block is ReentrancyGuard {
    using SafeMath for uint256;

    address payable owner;
    Recepients[] public members;

    mapping(address => uint256) userBalance;

    struct Recepients {
        uint256 share;
        address payable userAddress;
    }

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    constructor() {
        owner = payable(msg.sender);
    }

    function balance(address user) public view returns (uint256) {
        return address(user).balance;
    }

    function deposit() public payable nonReentrant {
        require(msg.value <= 5 * 10**18, "Yoho send less eth");
        userBalance[msg.sender] += msg.value;
        uint256 totalMembers = members.length;
        uint256 contractBalance = balance(address(this));

        for (uint256 i = 0; i < totalMembers; i++) {
            Recepients memory temp = members[i];
            uint256 _userShare = contractBalance.mul(temp.share).div(100);
            payable(temp.userAddress).transfer(_userShare);
        }
    }

    //specify the share of user
    function addMember(uint256 share, address payable _address)
        external
        onlyOwner
    {
        members.push(Recepients(share, _address));
    }
}
