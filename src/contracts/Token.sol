// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Token is ERC20 {
    address public minter;

    event MinterChanged(address indexed from, address to);

    constructor() public payable ERC20("Decentralized Bank Currency", "DBC") {
        minter = msg.sender;
    }

    function passMinterRole(address _dbank) public returns (bool) {
        require(
            msg.sender == minter,
            "Error, only owner can change pass minter role"
        );
        minter = _dbank;

        emit MinterChanged(msg.sender, _dbank);
        return true;
    }

    function mint(address account, uint256 amount) public {
        //check if msg.sender have minter role
        require(
            msg.sender == minter,
            "Error, msg.sender doesn't have minter role"
        );
        _mint(account, amount);
    }
}
