pragma solidity ^0.8.0;

import "./Unistoken.sol";
import "./SafeMath.sol";

contract Features is ERC20 {
    using SafeMath for uint256;
    address payable recipientETH;
    uint256 public smallNumber = 100000000000000000;
    uint256 public exchangNumber = 10000000000000000000000;
    uint256 public Referralrewardtotal = 1750000000000000000000000;
    uint256 public Referralreward = 3000000000000000000;
    uint256 public BuyTotal = 19250000000000000000000000;
    
    mapping(address => uint256) public Recomm;
    mapping(address => uint256) public withdrawNumber;
    mapping(address => mapping(address => uint)) public isexist;
    
    //event BuyTotal(uint256 BuyTotal);
    
    
    constructor(address payable recipientETH_,address uniswap,address team,address Listed)
        ERC20('unistoken','unis')
        public {
            recipientETH = recipientETH_;
            _mint(uniswap, 3500000 * (10 ** uint256(decimals())));
            _mint(team, 7000000 * (10 ** uint256(decimals())));
            _mint(Listed, 3500000 * (10 ** uint256(decimals())));
        }
    
    function buy(address Referrer) payable public {
        //return msg.value;
        address myaddress = msg.sender;
        require(msg.value >= smallNumber);
        require(Referrer != myaddress);
        require(msg.sender != recipientETH);
        
        //return msg.sender;
        //return msg.sender;
        uint256 SendNumber = msg.value.mul(exchangNumber).div(1000000000000000000);
        //this.transfer(myaddress,SendNumber);
        require(BuyTotal >= SendNumber);
        BuyTotal = BuyTotal.sub(SendNumber);
        _mint(myaddress,SendNumber);
        recipientETH.transfer(msg.value);
        if (isexist[Referrer][myaddress] == 0) {
            Recomm[Referrer] = Recomm[Referrer].add(1);
            isexist[Referrer][myaddress] = 1;
        }

    }
    
    function reward() public {
        require(Recomm[msg.sender] >= 30);
        require(withdrawNumber[msg.sender] == 0);
        uint256 rewardNumber = Referralreward.mul(30);
        //this.transfer(msg.sender,rewardNumber);
        require(Referralrewardtotal >= rewardNumber);
        Referralrewardtotal = Referralrewardtotal.sub(rewardNumber);
        _mint(msg.sender,rewardNumber);
        withdrawNumber[msg.sender] = 1;
    }
    
}