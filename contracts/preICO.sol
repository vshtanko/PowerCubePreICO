pragma solidity ^0.4.18;

contract PowerCubePreIcoToken {

    mapping(address => uint256) balances;
    uint256 public totalSupply;
    event Mint(address indexed to, uint256 amount);
    event MintFinished();

    function PowerCubePreIcoToken() {
    
    }

    function balanceOf(address _owner) public view returns (uint256 balance) {
        return balances[_owner];
    }

    function mint(address _to, uint256 _amount) onlyOwner canMint public returns (bool) {
        totalSupply = totalSupply.add(_amount);
        balances[_to] = balances[_to].add(_amount);
        Mint(_to, _amount);
        Transfer(address(0), _to, _amount);
        return true;
    }

    function finishMinting() onlyOwner canMint public returns (bool) {
        mintingFinished = true;
        MintFinished();
        return true;
    }

}