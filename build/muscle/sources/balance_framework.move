// module muscle::coin_framework {

//     use sui::object::{Self, UID};
//     use sui::tx_context::{Self, TxContext};
//     use sui::sui::SUI;
//     use sui::balance::{Self, Balance, Supply};
//     use std::string::String;
//     use sui::url::{Self, Url};
//     use std::option::{Self, Option};

//     // RESOURCE COIN
//     struct Coin<SUI> has key, store {
//         id: UID,
//         balance: Balance<SUI>,
//     }


//     struct CoinMetadata<SUI> has store, key {
//         id: UID, 
//         decimals: u8,
//         name: String,
//         symbol: String, 
//         description: String,
//         icon_url: Option<url::Url>

//     }

//     // cap to allow mint and burn of coin type
//     struct TreasuryCap<SUI> has store, key {
//         id: UID,
//         total_supply: Supply<SUI>,
//     }


//     //cap to allow freeze of type coin
//     struct DenyCap<SUI> has store, key {
//         id: UID,
//     }

//     // event for when currency is created
//     struct CurrencyCreated<SUI> has copy, drop {
//         decimals: u8,
//     }



//     // CONSTANTS COIN

//     const ENotEnough: u64 = 2;

//     const DENY_LIST_COIN_INDEX: u64 = 0;

//     const EBadWitness: u64 = 0;

//     const IInvalidArg: u64 = 1;



//     // FUNCTIONS COIN
    
//     public fun total_supply<SUI>(cap: &TreasuryCap<SUI>) : u64 {
//         balance::supply_value(&cap.total_supply)
//     }




//     public fun treausry_into_supply<SUI>(treasury: TreasuryCap<SUI> ): Supply<SUI> {

//         let TreasuryCap { id, total_supply  } = treasury;
//         object::delete(id);
//         total_supply

//     }


//     public fun supply_immut<SUI>(treasury: &TreasuryCap<SUI>) : &Supply<SUI> {
//         &treasury.total_supply
//     }




//     public fun supply_mut<SUI>(treasury: &mut TreasuryCap<SUI>) : &mut Supply<SUI> {
//         &mut treasury.total_supply
//     }



//     // getter for coin value
//     public fun value<SUI>(self: &Coin<SUI>) : u64 {
//         balance::value(&self.balance)
//     }


//     // getter for balance
//     public fun balance<SUI>(coin: &Coin<SUI>) : &Balance<SUI> {
//         &coin.balance
//     }


//     public fun balance_mut<SUI>(coin: &mut Coin<SUI>) : &mut Balance<SUI> {
//         &mut coin.balance
//     }




//     // wrap coin to make it transferable
//     public fun from_balance<SUI>(balance: Balance<SUI>, ctx: &mut TxContext ): Coin<SUI> {
//         Coin { id: object::new(ctx), balance }
//     }


    // deconstruct wrapper and keep balance
    // public fun into_balance<SUI>( coin: Coin<SUI>) : Balance<SUI> {

    //     let Coin { id, balance } = coin;
    //     object::delete(id);
    //     balance

    // }


    // take coin worth a value from an account
//    public fun take<SUI>(
//         balance: &mut Balance<SUI>, value: u64, ctx: &mut TxContext,
//     ): Coin<T> {
//         Coin {
//             id: object::new(ctx),
//             balance: balance::split(balance, value)
//         }
//     }



    // put coin in balance
    // public fun put<SUI>(balance: &mut Balance<SUI>, coin: Coin<SUI>) {
    //     balance::join(balance, into_balance(coin));
    // }



    // consume coin and add value to self
    // public entry fun join<SUI>(self: &mut Coin<SUI>, c: Coin<SUI>) {
    //     let Coin { id, balance } = c;
    //     object::delete(id);
    //     balance::join(&mut self.balance, balance);
    // }


    // split coin self into 2 coins
    // public fun split<SUI>(self: &mut Coin<SUI>, split_amount: u64, ctx: &mut TxContext) : Coin<SUI> {
    //     take(&mut self.balance, split_amount, ctx)
    // }

    


// }

// BALANCE FRAMEWORK
module muscle::balance_framework {

    use sui::tx_context::{Self, TxContext};
    use sui::balance::{Self, Balance};
    use sui::sui::SUI;
    use sui::coin::{Self, Coin};



    struct Supply<SUI> has store {
        value: u64,
    }


    // struct Balance<SUI> has store {
    //     values: u64,
    // }


    // CONSTANTS
    const ENotSystemAddress: u64 = 3;
    const ENonZero: u64 = 0;
    const ENotEnough: u64 = 2;
    const EOverfloe: u64 = 1;

    // FUNCTIONS
    
    // get amount stored in a balance
    // public fun value<SUI>(self: &Balance<SUI>) : u64 {
    //     self.value
    // }


    public fun supply_value<SUI>(supply: &Supply<SUI>): u64 {
        supply.value
    }


    // create supply
    public fun create_supply<SUI: drop>(_: SUI): Supply<SUI>{
        Supply { value: 0 }
    }


    // increase supply
    // public fun increase_supply<SUI>(self: &mut Supply<SUI>, value: u64): Balance<SUI> {

    //     assert!(value < (18446744073709551615u64 - self.value), EOverfloe);
    //     self.value = self.value + value;
    //     Balance { value }
    // }



    // zero
    // public fun zero<SUI>(): Balance<SUI> {
    //     Balance { value: 0 }
    // }


    // public fun join<SUI>(self: &mut Balance<SUI>, balance: BALANCE<SUI>): u64 {
    //     let Balance { value } = balance;
    //     self.value = self.value + value;
    //     self.value
    // }



}




// DYNAMIC FIELD FRAMEWORK
// module muscle::df_framework {

//     use sui::tx_context::{Self, TxContext};
//     use sui::object::{Self, UID};
//     use sui::dynamic_field as dfield;


//     struct Field<Name: copy, drop, store, Value: store> has key {
//         id: UID,
//         name: Name, 
//         value: Value,  
//     }



    // CONSTANTS
    // const EBCSSerializationFailure: u64 = 3;
    // const ESharedObjectOperationNotSupported: u64 = 4;
    // const EFieldAlreadyExists: u64 = 0;
    // const EFieldDoesNotExist: u64 = 1;
    // const EFieldTypeMismatch: u64 = 2;



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


