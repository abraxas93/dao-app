// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.4;

import "./IERC20.sol";

contract ERC20 is IERC20 {
    string private _name;
    string private _symbol;
    uint8 private _decimals;
    uint private _totalSupply;
    
    mapping(address => uint) private _balances;
    mapping(address => mapping(address => uint)) private _allowances;
    
    constructor(string memory name_, string memory symbol_, uint8 decimals_) {
        _name = name_;
        _symbol = symbol_;
        _decimals = decimals_;
    }
    
    function name() external view override returns (string memory) {
        return _name;
    }
    
    function symbol() external view override returns(string memory) {
        return _symbol;
    }
    
    function decimals() external view override returns (uint8) {
        return _decimals;
    }
    
    function totalSupply() external view override returns (uint256) {
        return _totalSupply;
    }
    
    function balanceOf(address _owner) external view override returns (uint256 balance) {
        return _balances[_owner];
    }
    
    function transfer(address _to, uint256 _value) external override returns (bool success) {
        require(_balances[msg.sender] >= _value, "NOT_ENOUGH_FUNDS");
        assert(_balances[msg.sender] > _balances[msg.sender] - _value);
        assert(_balances[_to] + _value > _balances[_to]);
        _balances[msg.sender] -= _value;
        _balances[_to] += _value;
        emit Transfer(msg.sender, _to, _value);
        return true;
    }
    
    function approve(address _spender, uint256 _value) external override returns (bool success) {
        require(msg.sender != address(0), "FROM_ZERO_ADDRESS");
        require(_spender != address(0), "TO_ZERO_ADDRESS");

        _allowances[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }
    
    function allowance(address _owner, address _spender) external view override returns (uint256 remaining) {
        return _allowances[_owner][_spender];
    }
    
    function transferFrom(address _from, address _to, uint256 _value) external override returns (bool success) {
        require(_balances[_from] >= _value, "NOT_ENOUGH_FUNDS");
        require(_allowances[_from][_to] >= _value, "NOT_ALLOWED");
        assert(_balances[_from] > _balances[_from] - _value);
        assert(_balances[_to] + _value > _balances[_to]);
        _balances[_from] -= _value;
        _balances[_to] += _value;
        _allowances[_from][_to] -= _value;
        return true;
    }

    function _mint(address _account, uint256 _amount) internal virtual {
        require(_account != address(0), "ERC2: mint to the zero address");
        // assert ???
        _totalSupply += _amount;
        _balances[_account] += _amount;
        emit Transfer(address(0), _account, _amount);
    }
}
