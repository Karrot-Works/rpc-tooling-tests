// contracts/TestTokenV2.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./TestTokenV1.sol";

contract TestTokenV2 is TestTokenV1 {
    function version() public pure returns (string memory) {
        return "v2!";
    }
}
