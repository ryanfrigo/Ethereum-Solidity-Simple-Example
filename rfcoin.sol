pragma solidity ^0.4.24;

contract RFCOIN {
    
    mapping (address => uint256) tokens;
    address public owner;
    uint256 totalSupply;
    
    constructor(uint256 _supply) public
    {
        totalSupply = _supply;
        owner = msg.sender;
        tokens[owner] = totalSupply;
    }
    
    function sendTokens(address to, uint256 amt) public
    {
        require(tokens[msg.sender] >= amt);
        tokens[msg.sender] -= amt;
        tokens[to] += amt;
    }
    
    function buyTokens() public payable {
        uint256 buy = msg.value / 10**16;
        require(tokens[owner] >= buy);
        tokens[owner] = buy;
        tokens[msg.sender] += buy;
    }
    
    modifier onlyOwner
    {
        require(msg.sender == owner);
        _;
    }
    
    function withdrawAll () public onlyOwner
    {
        msg.sender.transfer(address(this).balance);
    }
}
