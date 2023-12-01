// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ERC721, IERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {ERC721Burnable} from "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";
import {ERC721Enumerable} from "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import {AccessControl} from "@openzeppelin/contracts/access/AccessControl.sol";
import {Strings} from "@openzeppelin/contracts/utils/Strings.sol";

contract NftContract is
    ERC721,
    ERC721Burnable,
    ERC721Enumerable,
    AccessControl
{
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");

    bool private _isRevealed;
    string private _URI;
    address private _owner;
    string public baseExtension = ".json";

    constructor(
        address _initialOwner,
        string memory _name,
        string memory _symbol,
        string memory _initBaseURI,
        bool _initReveal
    ) ERC721(_name, _symbol) {
        require(_initialOwner != address(0), "inavalid initial owner");

        _grantRole(DEFAULT_ADMIN_ROLE, _initialOwner);
        _grantRole(MINTER_ROLE, _initialOwner);
        _transferOwnership(_initialOwner);
        // _reveal(_initReveal, _initBaseURI);
        _URI = _initBaseURI;
        _isRevealed = _initReveal;
        if (_initReveal) {
            emit Revealed(_URI);
        }
    }

    event Revealed(string baseURI);
    event OwnershipTransferred(
        address indexed previousOwner,
        address indexed newOwner
    );

    function setBaseURI(
        string calldata newBaseURI
    ) public onlyRole(DEFAULT_ADMIN_ROLE) {
        _URI = newBaseURI;
    }

    function setBaseExtension(
        string calldata _newBaseExtension
    ) public onlyRole(DEFAULT_ADMIN_ROLE) {
        baseExtension = _newBaseExtension;
    }

    function safeMint(
        address to,
        uint256 tokenId
    ) public onlyRole(MINTER_ROLE) {
        _safeMint(to, tokenId);
    }

    function tokenURI(
        uint256 tokenId
    ) public view override returns (string memory) {
        require(_ownerOf(tokenId) != address(0), "nonexistent token");

        // return super.tokenURI(_tokenId);
        return
            bytes(_baseURI()).length > 0
                ? string(
                    abi.encodePacked(
                        _baseURI(),
                        Strings.toString(tokenId),
                        baseExtension
                    )
                )
                : "";
    }

    function reveal(
        string calldata newBaseURI
    ) external onlyRole(DEFAULT_ADMIN_ROLE) {
        require(_isRevealed == false, "already revealed!");
        _URI = newBaseURI;
        _isRevealed = true;
        emit Revealed(_URI);
    }

    function revealed() public view returns (bool) {
        return _isRevealed;
    }

    function _baseURI() internal view override returns (string memory) {
        return _URI;
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        _checkOwner();
        _;
    }

    /**
     * @dev Returns the address of the current owner.
     */
    function owner() public view virtual returns (address) {
        return _owner;
    }

    /**
     * @dev Throws if the sender is not the owner.
     */
    function _checkOwner() internal view virtual {
        require(owner() == _msgSender(), "Ownable: caller is not the owner");
    }

    /**
     * @dev Leaves the contract without owner. It will not be possible to call
     * `onlyOwner` functions. Can only be called by the current owner.
     *
     * NOTE: Renouncing ownership will leave the contract without an owner,
     * thereby disabling any functionality that is only available to the owner.
     */
    function renounceOwnership()
        public
        virtual
        onlyOwner
        onlyRole(DEFAULT_ADMIN_ROLE)
    {
        _transferOwnership(address(0));
        _revokeRole(DEFAULT_ADMIN_ROLE, _owner);
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Can only be called by the current owner.
     */
    function transferOwnership(
        address newOwner
    ) public virtual onlyOwner onlyRole(DEFAULT_ADMIN_ROLE) {
        require(
            newOwner != address(0),
            "Ownable: new owner is the zero address"
        );
        require(newOwner != _owner, "Ownable: same as current owner");
        _grantRole(DEFAULT_ADMIN_ROLE, newOwner);
        _revokeRole(DEFAULT_ADMIN_ROLE, _owner);
        _transferOwnership(newOwner);
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Internal function without access restriction.
     */
    function _transferOwnership(address newOwner) internal virtual {
        address oldOwner = _owner;
        _owner = newOwner;
        emit OwnershipTransferred(oldOwner, newOwner);
    }

    // The following functions are overrides required by Solidity.

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenId,
        uint256 batchSize
    ) internal override(ERC721, ERC721Enumerable) {
        super._beforeTokenTransfer(from, to, tokenId, batchSize);
    }

    // function _update(
    //     address to,
    //     uint256 tokenId,
    //     address auth
    // ) internal override(ERC721, ERC721Enumerable) returns (address) {
    //     return super._update(to, tokenId, auth);
    // }

    // function _increaseBalance(
    //     address account,
    //     uint128 value
    // ) internal override(ERC721, ERC721Enumerable) {
    //     super._increaseBalance(account, value);
    // }

    function supportsInterface(
        bytes4 interfaceId
    )
        public
        view
        override(ERC721, ERC721Enumerable, AccessControl)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}
