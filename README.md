# DBank app with APY incentive as ERC20 Token

### Stack

* React.js – Frontend framework.
* Ganache – Runs local blockchain on Node.js environment.
* Truffle – Enables communication with blockchain for deployment and smart contract tests.
* Mocha/Chi – Test suite for smart contract testing on deployment.
* Web3 – Enables communication with local/remote Ethereum nodes 

### About

Developed a DeFi application for users to deposit and withdrawn Ethereum coins. Depositing Ethereum yields an additional gain of an ERC20 token with an APY of 10% with restrictions as followed:

* Deposit must be higher than 0.1 ETH.
* An address is only allowed to have a deposit active at the time. 

## How

#### Replicate environment.

Clone or fork this repository. 
> Before running: Ganache, Node.js and truffle must be installed.
> Dependencies must be install. Run `$ npm install` on directory.
	
#### Blockchain deployment and testing. 
	
Open Ganache.
Compile with truffle by running  `$ truffle compile`.
Run `$ truffle console` to interact with contract data and logic.
Testing suite is located in the `test.js` file under the test directory 
```
	-----Test
	       |___ test.js
```
           
Deployment is managed by truffle and executed running `$ truffle migrate` with the prefix  `--reset` the contract is been previously deployed.
