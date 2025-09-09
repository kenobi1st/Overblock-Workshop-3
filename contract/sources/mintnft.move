/// Module: mintnft
module mintnft::mintnft;

use std::string::String;
use sui::display;
use sui::event;
use sui::package;

// === Imports ===

// === Structs ===

/// Owned Object - NFT cane be accessed and modified by the owner
public struct Nft has key, store {
    // TODO: Add the fields for the NFT
    // 1. The id of the NFT
    // 2. The name of the NFT
    // 3. The description of the NFT
    // 4. The url of the NFT
    id: UID,
    name: String,
    description: String,
    url: String,
}

// Shared Object - Addresses that minted NFTs will be stored and everyone can access and modify it
public struct MintAddresses has key, store {
    // TODO: Add the fields for the MintAddresses
    // 1. The id of the MintAddresses object
    // 2. The addresses of the addresses that minted NFTs
    id: UID,
    addresses: vector<address>,
}

// Immutable Object - No one can modify this object
public struct NftMetadata has key, store {
    // TODO: Add the fields for the NftMetadata
    // 1. The id of the NftMetadata object
    // 2. The time stamp of the NftMetadata object
    id: UID,
    time_stamp: u64,
}

// ===OTW===
// TODO: Add the OTW for the package
public struct MINTNFT has drop {}

// === Events ===
public struct MintNftEvent has copy, drop {
    // TODO: Add the fields for the MintNftEvent
    // 1. The id of the NFT
    // 2. The name of the NFT
    id: ID,
    name: String,
}

// ===Initializers===
fun init(otw: MINTNFT, ctx: &mut TxContext) {
    // TODO: Create a MintAddresses object
    let addresses = MintAddresses { id: object::new(ctx), addresses: vector::empty() };

    // TODO: Claim package publisher rights
    let publisher = package::claim(otw, ctx);
    let mut display = display::new<Nft>(&publisher, ctx);

    // TODO: Set up NFT display object with metadata fields
    display.add(b"image_url".to_string(), b"{url}".to_string());
    display.update_version();

    // TODO: Transfer display and publisher to sender, share MintAddresses
    transfer::public_transfer(publisher, ctx.sender());
    transfer::public_transfer(display, ctx.sender());
    transfer::share_object(addresses);
}

// === Public Functions ===

public entry fun mint(
    mintAddresses: &mut MintAddresses,
    name: String,
    url: String,
    ctx: &mut TxContext,
) {
    // TODO: Create a new NFT object with name, description and url
    let nft = Nft {
        id: object::new(ctx),
        name,
        description: b"Kenobi".to_string(),
        url,
    };

    // TODO: Emit mint event with NFT id and name
    event::emit(MintNftEvent { id: object::id(&nft), name: name });

    // TODO: Transfer NFT to minter
    transfer::public_transfer(nft, ctx.sender());

    // TODO: Add minter address to tracking list
    vector::push_back(&mut mintAddresses.addresses, ctx.sender());

    // TODO: Create immutable metadata object with timestamp
    let nftMetadata = NftMetadata { id: object::new(ctx), time_stamp: ctx.epoch_timestamp_ms() };
    transfer::freeze_object(nftMetadata);
}

//Update Nft Name ------> This will not throw an error as it is a mutable object but only the owner can update it
public entry fun update_nft(nft: &mut Nft, name: String) {
  nft.name = name
}

// Update the nft metadata ------> This will not updated as it is a freezed object
public entry fun update_nft_metadata(nftMetadata: &mut NftMetadata, ctx: &mut TxContext) {
  nftMetadata.time_stamp = ctx.epoch_timestamp_ms();
}
