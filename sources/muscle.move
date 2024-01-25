module muscle::muscle {

    use sui::object::{Self, UID};
    use sui::tx_context::{Self, TxContext};
    use sui::sui::SUI;
    use sui::balance::{Self, Balance, Supply};
    use std::string::String;
    use sui::url::{Self, Url};
    use std::option::{Self, Option};

    // RESOURCE COIN
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

    // cap to allow mint and burn of coin type
    struct TreasuryCap<SUI> has store, key {
        id: UID,
        total_supply: Supply<SUI>,
    }


    //cap to allow freeze of type coin
    struct DenyCap<SUI> has store, key {
        id: UID,
    }

    // event for when currency is created
    struct CurrencyCreated<SUI> has copy, drop {
        decimals: u8,
    }



    // CONSTANTS COIN

    const ENotEnough: u64 = 2;

    const DENY_LIST_COIN_INDEX: u64 = 0;

    const EBadWitness: u64 = 0;

    const IInvalidArg: u64 = 1;



    // FUNCTIONS COIN
    
    public fun total_supply<SUI>(cap: &TreasuryCap<SUI>) : u64 {
        balance::supply_value(&cap.total_supply)
    }



}