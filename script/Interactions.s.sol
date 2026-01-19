//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script, console} from "../lib/forge-std/src/Script.sol";
import {DevOpsTool} from "../lib/foundry-devops/src/DevOpsTools.sol";
import {FundMe} from "../src/FundMe.sol";

contract FundFundMe is Script {
    string contractName = "FundMe";
    uint256 constant SEND_VALUE = 0.01 ether;

    function fundFundMe(address mostRecentlyDeployed) {
        vm.startBroadcast();
        FundMe(payable(mostRecentlyDeployed)).fund({value: SEND_VALUE});
        vm.stopBroadcast();

        console.log("Funded FundMe with %s", SEND_VALUE);
    }

    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment(contractName, block.chainId);

        fundFundMe(mostRecentlyDeployed);
    }
}

contract WithdrawFundMe is Script {}
