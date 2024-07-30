// contracts/TestTokenV1.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

contract TestTokenV1 is Initializable, ERC20Upgradeable {
    function initialize(uint256 initialSupply) public initializer {
        __ERC20_init("TestTokenV1", "TTK");
        _mint(msg.sender, initialSupply);
    }
}
