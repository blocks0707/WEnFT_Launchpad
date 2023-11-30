// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {NftContract} from "./NftContract.sol";
import {PresaleContract} from "./PresaleContract.sol";
import {MintContract} from "./MintContract.sol";

abstract contract AbsContrtactFactory {
    function deploy(
        string memory _name,
        string memory _symbol,
        string memory _initBaseURI,
        string memory _initNotRevealUri,
        address _initialOwner
    ) public virtual returns (address);
}

abstract contract AbsNftContract {
    function MINTER_ROLE() public virtual returns (bytes32);

    function grantRole(bytes32 role, address account) public virtual {}
}

contract WenftLaunchpadFactory {
    struct LaunchpadSet {
        address presaleContract;
        address mintContract;
    }

    mapping(address => LaunchpadSet) WenftLaunchpadSets;

    address _factory;

    event LaunchpadSetGenerated(
        address indexed nft,
        address presale,
        address mint
    );

    constructor() {}

    function setFactoryContract(address addr) public returns (address) {
        require(addr != address(0), "not allowded address");
        address prev = _factory;
        _factory = addr;
        return prev;
    }

    function generateLaunchpadSet(
        string memory _name,
        string memory _symbol,
        string memory _initBaseURI,
        string memory _initNotRevealUri,
        address _initialOwner
    ) public returns (address) {
        require(_initialOwner != address(0), "invalid initial owner");

        AbsContrtactFactory factory = AbsContrtactFactory(address(0));
        address addr = factory.deploy(
            _name,
            _symbol,
            _initBaseURI,
            _initNotRevealUri,
            _initialOwner
        );
        // NftContract nft = new NftContract(
        //     _initialOwner,
        //     _name,
        //     _symbol,
        //     _initBaseURI,
        //     _initNotRevealUri
        // );
        PresaleContract presale = new PresaleContract(
            _initialOwner,
            addr,
            address(0)
        );
        MintContract mint = new MintContract(_initialOwner, addr, address(0));

        NftContract nftContract = NftContract(addr);
        nftContract.grantRole(nftContract.MINTER_ROLE(), address(presale));
        nftContract.grantRole(nftContract.MINTER_ROLE(), address(mint));

        WenftLaunchpadSets[address(0)] = LaunchpadSet(
            address(presale),
            address(mint)
        );

        emit LaunchpadSetGenerated(addr, address(presale), address(mint));

        return (address(0));
    }

    function getLaunchpadSet(
        address addr
    ) public view returns (address, address, address) {
        LaunchpadSet memory set = WenftLaunchpadSets[addr];
        return (addr, set.presaleContract, set.mintContract);
    }
}
