module muscle::coin_framework {

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




    public fun treausry_into_supply<SUI>(treasury: TreasuryCap<SUI> ): Supply<SUI> {

        let TreasuryCap { id, total_supply  } = treasury;
        object::delete(id);
        total_supply

    }


    public fun supply_immut<SUI>(treasury: &TreasuryCap<SUI>) : &Supply<SUI> {
        &treasury.total_supply
    }




    public fun supply_mut<SUI>(treasury: &mut TreasuryCap<SUI>) : &mut Supply<SUI> {
        &mut treasury.total_supply
    }



    // getter for coin value
    public fun value<SUI>(self: &Coin<SUI>) : u64 {
        balance::value(&self.balance)
    }


    // getter for balance
    public fun balance<SUI>(coin: &Coin<SUI>) : &Balance<SUI> {
        &coin.balance
    }


    public fun balance_mut<SUI>(coin: &mut Coin<SUI>) : &mut Balance<SUI> {
        &mut coin.balance
    }




    // wrap coin to make it transferable
    public fun from_balance<SUI>(balance: Balance<SUI>, ctx: &mut TxContext ): Coin<SUI> {
        Coin { id: object::new(ctx), balance }
    }


    // deconstruct wrapper and keep balance
    public fun into_balance<SUI>( coin: Coin<SUI>) : Balance<SUI> {

        let Coin { id, balance } = coin;
        object::delete(id);
        balance

    }


    





}




// Dynamic Field Module
module muscle::df_framework {

    use sui::tx_context::{Self, TxContext};
    use sui::object::{Self, UID};
    use sui::dynamic_field as dfield;


    struct Field<Name: copy, drop, store, Value: store> has key {
        id: UID,
        name: Name, 
        value: Value,  
    }



    // CONSTANTS
    const EBCSSerializationFailure: u64 = 3;
    const ESharedObjectOperationNotSupported: u64 = 4;
    const EFieldAlreadyExists: u64 = 0;
    const EFieldDoesNotExist: u64 = 1;
    const EFieldTypeMismatch: u64 = 2;



    // FUNCTIONS

   
    // add df to object
//    public fun add<Name: copy + drop + store, Value: store>(
//         object: &mut UID,
//         name: Name,
//         value: Value,
//     ) {

//         let object_addr = object::uid_to_address(object);
//         let hash = hash_type_and_key(object_addr, name);
//         assert!(!has_child_object(object_addr, hash), EFieldAlreadyExists);
//         let field = Field {
//             id: object::new_uid_from_hash(hash),
//             name,
//             value,
//     };
    
//     add_child_object(object_addr, field)

//     }


    // public fun borrow<Name: copy, drop, store, Value: store> (object: &UID, name: Name) : &Value {
        
    //     let object_addr = object::uid_to_address(object);
    //     let hash = hash_type_and_key(object_addr, name);
    //     let field = borrow_child_object<Field<Name, Value>>(object, hash);
    //     &field.value

    // }


}