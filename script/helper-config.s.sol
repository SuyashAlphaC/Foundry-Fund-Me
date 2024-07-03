//SPDX-License-Identifier:MIT

pragma solidity ^0.8.18;
import "forge-std/Script.sol";
import {MockV3Aggregator} from "../test/mocks/MockV3Aggregator.sol";

contract helperConfig is Script {
    struct networkConfig {
        address priceFeed;
    }

    networkConfig public activeNetworkConfig;

    constructor() {
        if (block.chainid == 11155111) {
            activeNetworkConfig = getSepoliaEthConfig();
        } else if (block.chainid == 1) {
            activeNetworkConfig = getEthereumConfig();
        } else {
            activeNetworkConfig = getAnvilEthConfig();
        }
    }

    function getSepoliaEthConfig() public pure returns (networkConfig memory) {
        networkConfig memory sepoliaConfig = networkConfig({
            priceFeed: 0x694AA1769357215DE4FAC081bf1f309aDC325306
        });
        return sepoliaConfig;
    }

    function getEthereumConfig() public pure returns (networkConfig memory) {
        networkConfig memory ethConfig = networkConfig({
            priceFeed: 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419
        });
        return ethConfig;
    }

    function getAnvilEthConfig() public returns (networkConfig memory) {
        if (activeNetworkConfig.priceFeed != address(0)) {
            return activeNetworkConfig;
        }
        vm.startBroadcast();

        MockV3Aggregator mockV3Aggregator = new MockV3Aggregator(8, 2000e8);
        vm.stopBroadcast();
        networkConfig memory mockConfig = networkConfig({
            priceFeed: address(mockV3Aggregator)
        });
        return mockConfig;
    }
}
