module muscle::muscle {

    use sui::object::{Self, UID};
    use sui::tx_context::{Self, TxContext};
    use sui::sui::SUI;
    use sui::balance::{Self, Balance, Supply};
    use std::string::String;
    use sui::url::{Self, Url};
    use std::option::{Self, Option};

    // Resource Coin
    struct Coin<SUI> has key, store {
        id: UID,
        balance: Balance<SUI>,
    }


    struct CoinMetadata<SUI> has store, key {
        id: UID, 
        decimals: u8,
        name: String,
        symbol: String, 
        description: String,
        icon_url: Option<url::Url>

    }

    
    struct TreasuryCap<SUI> has store, key {
        id: UID,
        total_supply: Supply<SUI>,
    }

}