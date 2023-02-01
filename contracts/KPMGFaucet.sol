pragma solidity ^0.8.9;

import "./Ownable.sol";

contract KPMGFaucet is Ownable {
    //state variable to keep track of owner and amount of ETHER to dispense

    uint256 public amountAllowed = 10000000000000000;
    //0.01 matic, 10^16

    //mapping to keep track of requested rokens
    //Address and blocktime + 1 day is saved in TimeLock
    mapping(address => uint256) public lockTime;

    //constructor to set the owner

    //function to change the owner.  Only the owner of the contract can call this function

    //function to set the amount allowable to be claimed. Only the owner can call this function
    function setAmountallowed(uint256 newAmountAllowed) public onlyOwner {
        amountAllowed = newAmountAllowed;
    }

    //function to donate funds to the faucet contract
    function donateToFaucet() public payable {}

    //function to send tokens from faucet to an address
    function requestTokens(address payable _requestor) public payable {
        //perform a few checks to make sure function can execute
        require(
            block.timestamp > lockTime[msg.sender],
            "lock time has not expired. Please try again later"
        );
        require(
            address(this).balance > amountAllowed,
            "Not enough funds in the faucet. Please donate"
        );

        //if the balance of this contract is greater then the requested amount send funds
        _requestor.transfer(amountAllowed);

        //updates locktime 1 day from now
        lockTime[msg.sender] = block.timestamp + 1 days;
    }
}
