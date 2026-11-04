use std::sync::{Arc, RwLock};

struct Account {
    amount: i32,
    _name: String,
}

fn main() {
    loop {
        let account = Account {
            amount: 1000,
            _name: "Mr. Minister's account".to_string(),
        };

        let account_handle1 = Arc::new(RwLock::new(account));
        let account_handle2 = Arc::clone(&account_handle1);
        let account_handle3 = Arc::clone(&account_handle1);

        std::thread::spawn(move || deduce_600(account_handle1));
        std::thread::spawn(move || deduce_600(account_handle2));

        let result = account_handle3.read().unwrap().amount;

        println!("{result}");

        if result < 0 {
            break;
        };
    }
}

fn deduce_600(account: Arc<RwLock<Account>>) {
    let current_amount = account.read().unwrap().amount;

    if current_amount > 600 {
        account.write().unwrap().amount -= 600;
    };
}
