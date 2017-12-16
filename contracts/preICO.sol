pragma solidity ^0.4.18;

contract PowerCubePreSale {

    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        assert(b <= a);
        return a - b;
    }

    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        assert(c >= a);
        return c;
    }

    mapping(address => uint256) balances;
    address public admin;
    uint256 public totalSupply;
    uint256 public currentSupply;
    event Mint(address indexed to, uint256 amount);
    event Burn(address indexed from, uint256 amount);
    event MintFinished();

    string public constant symbol = "PCB/1";
    string public constant name = "PowerCube preSale";
    uint8 public constant decimals = 0;

    function PowerCubePreSale() public {
        admin = msg.sender;
        totalSupply = 10000;
        currentSupply = totalSupply;
    }

    modifier onlyAdmin() {
        require(msg.sender == admin);
        _;
    }

    function balanceOf(address _owner) public view returns (uint256 balance) {
        return balances[_owner];
    }

    function totalSupply() public view returns (uint) {
        return totalSupply;
    }

    function currentSupply() public view returns (uint) {
        return currentSupply;
    }

    function getPreSaleTokenPool() public view returns (uint) {
        return totalSupply - currentSupply;
    }

    function mint(address _to, uint256 _amount) onlyAdmin public returns (bool) {
        require(_amount <= currentSupply);
        currentSupply = sub(currentSupply, _amount);
        balances[_to] = add(balances[_to], _amount);
        Mint(_to, _amount);
        return true;
    }

    function burn(address _from, uint256 _amount) onlyAdmin public returns (bool) {
        require(_amount <= balances[_from]);
        currentSupply = add(currentSupply, _amount);
        balances[_from] = sub(balances[_from], _amount);
        Burn(_from, _amount);
        return true;
    }

    function changeAdmin(address newAdmin) onlyAdmin public returns (bool) {
        admin = newAdmin;
        return true;
    }

}