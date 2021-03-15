// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.8.0;

import "./Token.sol";

contract dBank {
    // My token address and information
    Token private token;

    //pass as constructor argument deployed Token contract
    constructor(Token _token) public {
        token = _token;
    }

    //Mapping user data on contract run
    mapping(address => uint256) public etherBalanceOf;
    mapping(address => uint256) public depositStart;
    mapping(address => bool) public isDeposited;

    // Console events
    event Deposit(address indexed user, uint256 etherAmount, uint256 timeStart);
    event Withdraw(
        address indexed user,
        uint256 etherAmount,
        uint256 timeStart,
        uint256 interest
    );

    function deposit() public payable {
        require(
            isDeposited[msg.sender] == false,
            "Error, deposit already active"
        );
        require(msg.value >= 1e16, "Error, deposite must be >= 0.01 ETH");

        etherBalanceOf[msg.sender] = etherBalanceOf[msg.sender] + msg.value;
        depositStart[msg.sender] = depositStart[msg.sender] + block.timestamp;

        isDeposited[msg.sender] = true;
        emit Deposit(msg.sender, msg.value, block.timestamp);
    }

    function withdraw() public {
        uint256 userBalance = etherBalanceOf[msg.sender];
        // require user to have deposited before
        require(
            isDeposited[msg.sender] == true,
            "Make a deposite before withdrawing"
        );

        // calculating apy for alt token
        uint256 depositeTime = block.timestamp - depositStart[msg.sender];
        uint256 interestPerSecond = 31668017 * (userBalance / 1e16);
        uint256 interest = interestPerSecond * depositeTime;

        // send ether in addition to our tokens
        msg.sender.transfer(etherBalanceOf[msg.sender]);
        token.mint(msg.sender, interest);

        // reseting for new deposit
        etherBalanceOf[msg.sender] = 0;
        depositStart[msg.sender] = 0;
        isDeposited[msg.sender] = false;

        // Emit events
        emit Withdraw(msg.sender, userBalance, block.timestamp, interest);
    }
}
