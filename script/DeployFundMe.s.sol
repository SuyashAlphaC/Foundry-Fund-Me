//SPDX-License-Identifier:MIT

pragma solidity ^0.8.18;
import "../src/FundMe.sol";
import "forge-std/Script.sol";
import "./helper-config.s.sol";

contract DeployFundMe is Script {
    function run() external returns (FundMe) {
        helperConfig HelperConfig = new helperConfig();
        address ethUsdPriceFeed = HelperConfig.activeNetworkConfig();

        vm.startBroadcast();
        FundMe fundMe = new FundMe(ethUsdPriceFeed);
        vm.stopBroadcast();
        return fundMe;
    }
}
