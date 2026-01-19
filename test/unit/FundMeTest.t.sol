//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test} from "../../lib/forge-std/src/Test.sol";
import {FundMe} from "../../src/FundMe.sol";
import {DeployFundMe} from "../../script/DeployFundMe.s.sol";

contract FundMeTest is Test {
    FundMe fundMe;

    function setUp() public {
        DeployFundMe deployer = new DeployFundMe();
        fundMe = deployer.run();
    }

    function testMinDollarIsFive() public view {
        assertEq(fundMe.MINIMUM_USD(), 5);
    }

    function testOwnerIsMsgSender() public view {
        assertEq(fundMe.I_OWNER(), address(msg.sender));
    }

    function testFundFailsWithoutEnoghETH() public {
        vm.expectRevert();
        fundMe.fund();
    }
}
