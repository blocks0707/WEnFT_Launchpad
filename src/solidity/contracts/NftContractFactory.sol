// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {NftContract} from "./NftContract.sol";

contract NftContractFactory {
    mapping(address => string[]) NftContracts;

    event Deployed(address indexed addr, string name, string symbol);

    constructor() {}

    function deploy(
        string memory _name,
        string memory _symbol,
        string memory _initBaseURI,
        bool _initReveal,
        address _initialOwner
    ) public returns (address) {
        require(_initialOwner != address(0), "invalid initial owner");

        NftContract nft = new NftContract(
            _initialOwner,
            _name,
            _symbol,
            _initBaseURI,
            _initReveal
        );

        NftContracts[address(nft)] = [_name, _symbol];

        emit Deployed(address(nft), _name, _symbol);

        return (address(nft));
    }

    function getContract(
        address addr
    ) public view returns (address, string memory, string memory) {
        string[] memory info = NftContracts[addr];
        return (addr, info[0], info[1]);
    }
}
