# ERC721ACloneable
[Git Source](https://github.com/Provenance-Market/Provenance-AI-Backend-v2/blob/fbadee5cddd353412cd3f65d2fe397629bb40751/src/clones/ERC721ACloneable.sol)

**Inherits:**
IERC721A, Initializable

*Implementation of the [ERC721](https://eips.ethereum.org/EIPS/eip-721)
Non-Fungible Token Standard, including the Metadata extension.
Optimized for lower gas during batch mints.
Token IDs are minted in sequential order (e.g. 0, 1, 2, 3, ...)
starting from `_startTokenId()`.
Assumptions:
- An owner cannot have more than 2**64 - 1 (max value of uint64) of supply.
- The maximum token ID cannot exceed 2**256 - 1 (max value of uint256).*


## State Variables
### _BITMASK_ADDRESS_DATA_ENTRY

```solidity
uint256 private constant _BITMASK_ADDRESS_DATA_ENTRY = (1 << 64) - 1;
```


### _BITPOS_NUMBER_MINTED

```solidity
uint256 private constant _BITPOS_NUMBER_MINTED = 64;
```


### _BITPOS_NUMBER_BURNED

```solidity
uint256 private constant _BITPOS_NUMBER_BURNED = 128;
```


### _BITPOS_AUX

```solidity
uint256 private constant _BITPOS_AUX = 192;
```


### _BITMASK_AUX_COMPLEMENT

```solidity
uint256 private constant _BITMASK_AUX_COMPLEMENT = (1 << 192) - 1;
```


### _BITPOS_START_TIMESTAMP

```solidity
uint256 private constant _BITPOS_START_TIMESTAMP = 160;
```


### _BITMASK_BURNED

```solidity
uint256 private constant _BITMASK_BURNED = 1 << 224;
```


### _BITPOS_NEXT_INITIALIZED

```solidity
uint256 private constant _BITPOS_NEXT_INITIALIZED = 225;
```


### _BITMASK_NEXT_INITIALIZED

```solidity
uint256 private constant _BITMASK_NEXT_INITIALIZED = 1 << 225;
```


### _BITPOS_EXTRA_DATA

```solidity
uint256 private constant _BITPOS_EXTRA_DATA = 232;
```


### _BITMASK_EXTRA_DATA_COMPLEMENT

```solidity
uint256 private constant _BITMASK_EXTRA_DATA_COMPLEMENT = (1 << 232) - 1;
```


### _BITMASK_ADDRESS

```solidity
uint256 private constant _BITMASK_ADDRESS = (1 << 160) - 1;
```


### _MAX_MINT_ERC2309_QUANTITY_LIMIT

```solidity
uint256 private constant _MAX_MINT_ERC2309_QUANTITY_LIMIT = 5000;
```


### _TRANSFER_EVENT_SIGNATURE

```solidity
bytes32 private constant _TRANSFER_EVENT_SIGNATURE = 0xddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef;
```


### _currentIndex

```solidity
uint256 private _currentIndex;
```


### _burnCounter

```solidity
uint256 private _burnCounter;
```


### _name

```solidity
string private _name;
```


### _symbol

```solidity
string private _symbol;
```


### _packedOwnerships

```solidity
mapping(uint256 => uint256) private _packedOwnerships;
```


### _packedAddressData

```solidity
mapping(address => uint256) private _packedAddressData;
```


### _tokenApprovals

```solidity
mapping(uint256 => TokenApprovalRef) private _tokenApprovals;
```


### _operatorApprovals

```solidity
mapping(address => mapping(address => bool)) private _operatorApprovals;
```


## Functions
### __ERC721ACloneable__init


```solidity
function __ERC721ACloneable__init(string memory name_, string memory symbol_) internal onlyInitializing;
```

### _startTokenId

*Returns the starting token ID.
To change the starting token ID, please override this function.*


```solidity
function _startTokenId() internal view virtual returns (uint256);
```

### _nextTokenId

*Returns the next token ID to be minted.*


```solidity
function _nextTokenId() internal view virtual returns (uint256);
```

### totalSupply

*Returns the total number of tokens in existence.
Burned tokens will reduce the count.
To get the total number of tokens minted, please see {_totalMinted}.*


```solidity
function totalSupply() public view virtual override returns (uint256);
```

### _totalMinted

*Returns the total amount of tokens minted in the contract.*


```solidity
function _totalMinted() internal view virtual returns (uint256);
```

### _totalBurned

*Returns the total number of tokens burned.*


```solidity
function _totalBurned() internal view virtual returns (uint256);
```

### balanceOf

*Returns the number of tokens in `owner`'s account.*


```solidity
function balanceOf(address owner) public view virtual override returns (uint256);
```

### _numberMinted

Returns the number of tokens minted by `owner`.


```solidity
function _numberMinted(address owner) internal view returns (uint256);
```

### _numberBurned

Returns the number of tokens burned by or on behalf of `owner`.


```solidity
function _numberBurned(address owner) internal view returns (uint256);
```

### _getAux

Returns the auxiliary data for `owner`. (e.g. number of whitelist mint slots used).


```solidity
function _getAux(address owner) internal view returns (uint64);
```

### _setAux

Sets the auxiliary data for `owner`. (e.g. number of whitelist mint slots used).
If there are multiple variables, please pack them into a uint64.


```solidity
function _setAux(address owner, uint64 aux) internal virtual;
```

### supportsInterface

*Returns true if this contract implements the interface defined by
`interfaceId`. See the corresponding
[EIP section](https://eips.ethereum.org/EIPS/eip-165#how-interfaces-are-identified)
to learn more about how these ids are created.
This function call must use less than 30000 gas.*


```solidity
function supportsInterface(bytes4 interfaceId) public view virtual override returns (bool);
```

### name

*Returns the token collection name.*


```solidity
function name() public view virtual override returns (string memory);
```

### symbol

*Returns the token collection symbol.*


```solidity
function symbol() public view virtual override returns (string memory);
```

### tokenURI

*Returns the Uniform Resource Identifier (URI) for `tokenId` token.*


```solidity
function tokenURI(uint256 tokenId) public view virtual override returns (string memory);
```

### _baseURI

*Base URI for computing {tokenURI}. If set, the resulting URI for each
token will be the concatenation of the `baseURI` and the `tokenId`. Empty
by default, it can be overridden in child contracts.*


```solidity
function _baseURI() internal view virtual returns (string memory);
```

### ownerOf

*Returns the owner of the `tokenId` token.
Requirements:
- `tokenId` must exist.*


```solidity
function ownerOf(uint256 tokenId) public view virtual override returns (address);
```

### _ownershipOf

*Gas spent here starts off proportional to the maximum mint batch size.
It gradually moves to O(1) as tokens get transferred around over time.*


```solidity
function _ownershipOf(uint256 tokenId) internal view virtual returns (TokenOwnership memory);
```

### _ownershipAt

*Returns the unpacked `TokenOwnership` struct at `index`.*


```solidity
function _ownershipAt(uint256 index) internal view virtual returns (TokenOwnership memory);
```

### _initializeOwnershipAt

*Initializes the ownership slot minted at `index` for efficiency purposes.*


```solidity
function _initializeOwnershipAt(uint256 index) internal virtual;
```

### _packedOwnershipOf

Returns the packed ownership data of `tokenId`.


```solidity
function _packedOwnershipOf(uint256 tokenId) private view returns (uint256);
```

### _unpackedOwnership

*Returns the unpacked `TokenOwnership` struct from `packed`.*


```solidity
function _unpackedOwnership(uint256 packed) private pure returns (TokenOwnership memory ownership);
```

### _packOwnershipData

*Packs ownership data into a single uint256.*


```solidity
function _packOwnershipData(address owner, uint256 flags) private view returns (uint256 result);
```

### _nextInitializedFlag

*Returns the `nextInitialized` flag set if `quantity` equals 1.*


```solidity
function _nextInitializedFlag(uint256 quantity) private pure returns (uint256 result);
```

### approve

*Gives permission to `to` to transfer `tokenId` token to another account.
The approval is cleared when the token is transferred.
Only a single account can be approved at a time, so approving the
zero address clears previous approvals.
Requirements:
- The caller must own the token or be an approved operator.
- `tokenId` must exist.
Emits an {Approval} event.*


```solidity
function approve(address to, uint256 tokenId) public virtual override;
```

### getApproved

*Returns the account approved for `tokenId` token.
Requirements:
- `tokenId` must exist.*


```solidity
function getApproved(uint256 tokenId) public view virtual override returns (address);
```

### setApprovalForAll

*Approve or remove `operator` as an operator for the caller.
Operators can call {transferFrom} or {safeTransferFrom}
for any token owned by the caller.
Requirements:
- The `operator` cannot be the caller.
Emits an {ApprovalForAll} event.*


```solidity
function setApprovalForAll(address operator, bool approved) public virtual override;
```

### isApprovedForAll

*Returns if the `operator` is allowed to manage all of the assets of `owner`.
See {setApprovalForAll}.*


```solidity
function isApprovedForAll(address owner, address operator) public view virtual override returns (bool);
```

### _exists

*Returns whether `tokenId` exists.
Tokens can be managed by their owner or approved accounts via {approve} or {setApprovalForAll}.
Tokens start existing when they are minted. See {_mint}.*


```solidity
function _exists(uint256 tokenId) internal view virtual returns (bool);
```

### _isSenderApprovedOrOwner

*Returns whether `msgSender` is equal to `approvedAddress` or `owner`.*


```solidity
function _isSenderApprovedOrOwner(address approvedAddress, address owner, address msgSender)
    private
    pure
    returns (bool result);
```

### _getApprovedSlotAndAddress

*Returns the storage slot and value for the approved address of `tokenId`.*


```solidity
function _getApprovedSlotAndAddress(uint256 tokenId)
    private
    view
    returns (uint256 approvedAddressSlot, address approvedAddress);
```

### transferFrom

*Transfers `tokenId` from `from` to `to`.
Requirements:
- `from` cannot be the zero address.
- `to` cannot be the zero address.
- `tokenId` token must be owned by `from`.
- If the caller is not `from`, it must be approved to move this token
by either {approve} or {setApprovalForAll}.
Emits a {Transfer} event.*


```solidity
function transferFrom(address from, address to, uint256 tokenId) public virtual override;
```

### safeTransferFrom

*Equivalent to `safeTransferFrom(from, to, tokenId, '')`.*


```solidity
function safeTransferFrom(address from, address to, uint256 tokenId) public virtual override;
```

### safeTransferFrom

*Safely transfers `tokenId` token from `from` to `to`.
Requirements:
- `from` cannot be the zero address.
- `to` cannot be the zero address.
- `tokenId` token must exist and be owned by `from`.
- If the caller is not `from`, it must be approved to move this token
by either {approve} or {setApprovalForAll}.
- If `to` refers to a smart contract, it must implement
{IERC721Receiver-onERC721Received}, which is called upon a safe transfer.
Emits a {Transfer} event.*


```solidity
function safeTransferFrom(address from, address to, uint256 tokenId, bytes memory _data) public virtual override;
```

### _beforeTokenTransfers

*Hook that is called before a set of serially-ordered token IDs
are about to be transferred. This includes minting.
And also called before burning one token.
`startTokenId` - the first token ID to be transferred.
`quantity` - the amount to be transferred.
Calling conditions:
- When `from` and `to` are both non-zero, `from`'s `tokenId` will be
transferred to `to`.
- When `from` is zero, `tokenId` will be minted for `to`.
- When `to` is zero, `tokenId` will be burned by `from`.
- `from` and `to` are never both zero.*


```solidity
function _beforeTokenTransfers(address from, address to, uint256 startTokenId, uint256 quantity) internal virtual;
```

### _afterTokenTransfers

*Hook that is called after a set of serially-ordered token IDs
have been transferred. This includes minting.
And also called after one token has been burned.
`startTokenId` - the first token ID to be transferred.
`quantity` - the amount to be transferred.
Calling conditions:
- When `from` and `to` are both non-zero, `from`'s `tokenId` has been
transferred to `to`.
- When `from` is zero, `tokenId` has been minted for `to`.
- When `to` is zero, `tokenId` has been burned by `from`.
- `from` and `to` are never both zero.*


```solidity
function _afterTokenTransfers(address from, address to, uint256 startTokenId, uint256 quantity) internal virtual;
```

### _checkContractOnERC721Received

*Private function to invoke {IERC721Receiver-onERC721Received} on a target contract.
`from` - Previous owner of the given token ID.
`to` - Target address that will receive the token.
`tokenId` - Token ID to be transferred.
`_data` - Optional data to send along with the call.
Returns whether the call correctly returned the expected magic value.*


```solidity
function _checkContractOnERC721Received(address from, address to, uint256 tokenId, bytes memory _data)
    private
    returns (bool);
```

### _mint

*Mints `quantity` tokens and transfers them to `to`.
Requirements:
- `to` cannot be the zero address.
- `quantity` must be greater than 0.
Emits a {Transfer} event for each mint.*


```solidity
function _mint(address to, uint256 quantity) internal virtual;
```

### _mintERC2309

*Mints `quantity` tokens and transfers them to `to`.
This function is intended for efficient minting only during contract creation.
It emits only one {ConsecutiveTransfer} as defined in
[ERC2309](https://eips.ethereum.org/EIPS/eip-2309),
instead of a sequence of {Transfer} event(s).
Calling this function outside of contract creation WILL make your contract
non-compliant with the ERC721 standard.
For full ERC721 compliance, substituting ERC721 {Transfer} event(s) with the ERC2309
{ConsecutiveTransfer} event is only permissible during contract creation.
Requirements:
- `to` cannot be the zero address.
- `quantity` must be greater than 0.
Emits a {ConsecutiveTransfer} event.*


```solidity
function _mintERC2309(address to, uint256 quantity) internal virtual;
```

### _safeMint

*Safely mints `quantity` tokens and transfers them to `to`.
Requirements:
- If `to` refers to a smart contract, it must implement
{IERC721Receiver-onERC721Received}, which is called for each safe transfer.
- `quantity` must be greater than 0.
See {_mint}.
Emits a {Transfer} event for each mint.*


```solidity
function _safeMint(address to, uint256 quantity, bytes memory _data) internal virtual;
```

### _safeMint

*Equivalent to `_safeMint(to, quantity, '')`.*


```solidity
function _safeMint(address to, uint256 quantity) internal virtual;
```

### _burn

*Equivalent to `_burn(tokenId, false)`.*


```solidity
function _burn(uint256 tokenId) internal virtual;
```

### _burn

*Destroys `tokenId`.
The approval is cleared when the token is burned.
Requirements:
- `tokenId` must exist.
Emits a {Transfer} event.*


```solidity
function _burn(uint256 tokenId, bool approvalCheck) internal virtual;
```

### _setExtraDataAt

*Directly sets the extra data for the ownership data `index`.*


```solidity
function _setExtraDataAt(uint256 index, uint24 extraData) internal virtual;
```

### _extraData

*Called during each token transfer to set the 24bit `extraData` field.
Intended to be overridden by the cosumer contract.
`previousExtraData` - the value of `extraData` before transfer.
Calling conditions:
- When `from` and `to` are both non-zero, `from`'s `tokenId` will be
transferred to `to`.
- When `from` is zero, `tokenId` will be minted for `to`.
- When `to` is zero, `tokenId` will be burned by `from`.
- `from` and `to` are never both zero.*


```solidity
function _extraData(address from, address to, uint24 previousExtraData) internal view virtual returns (uint24);
```

### _nextExtraData

*Returns the next extra data for the packed ownership data.
The returned result is shifted into position.*


```solidity
function _nextExtraData(address from, address to, uint256 prevOwnershipPacked) private view returns (uint256);
```

### _msgSenderERC721A

*Returns the message sender (defaults to `msg.sender`).
If you are writing GSN compatible contracts, you need to override this function.*


```solidity
function _msgSenderERC721A() internal view virtual returns (address);
```

### _toString

*Converts a uint256 to its ASCII string decimal representation.*


```solidity
function _toString(uint256 value) internal pure virtual returns (string memory str);
```

## Structs
### TokenApprovalRef

```solidity
struct TokenApprovalRef {
    address value;
}
```

