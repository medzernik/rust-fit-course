---
title: Type system, ownership, borrowing
author: Matej & David
options:
  implicit_slide_ends: true
---

Something About Us
===
<!-- column_layout: [1, 1] -->
<!-- column: 0 -->

# Matej

Software Engineer, Senior

## Worked at:

- **Honeywell** (navigation systems for Aircraft)
- **Rockwell Automation, s. r. o.** (Rust engineer)

## Free Time & Interests

- LEGO
- Strategy games
- History
- Astronomy
- Rust

## Contact

- @matejalmi – Discord, ...
- [LinkedIn](https://www.linkedin.com/in/matej-almáši-166973248/)
<!-- pause -->

<!-- column: 1 -->

# David

Software Engineer, Senior

## Worked at:

- **CGI** (design of navigation algorithms)
- **Wooting** (firmware, apps (in Rust!), frontend)
- **Správa Železnic, s. o.** (frontend developer)
- **Rockwell Automation, s. r. o.** (Rust engineer)

## Free Time & Interests

- Trying to contribute to the Rust project (clippy, bors, triagebot)
- Gaming (indie games, immersive sims, FPS, MOBAs)
- Exploring random tools (nushell)
- Buying useless tech and keyboards
- Rust

## Contact

- @medzernik - Discord, Signal, Telegram, Steam, GitHub, SourceHut ...
- [LinkedIn](https://www.linkedin.com/in/david-manca/)

Type System - Tuples I.
===

```rust +exec +line_numbers
fn main() {
    let bank_acc_david = ("David", 939938.34);
    let bank_acc_matej = ("Matej", 23.);
    
    print_acc(bank_acc_david);
    print_acc(bank_acc_matej);
}

fn print_acc(account: (&str, f64)) {
    println!("Account: {}, amount: {}", account.0, account.1);
}
```

Type System - Tuples II.
===


```rust +exec +line_numbers
fn main() {
    let bank_acc_david = ("David", 939938.34);
    let (name, amount) = bank_acc_david;    
    
    println!("Account: {name}, amount: {amount}");

}
```

Type System - Tuple Structs
===
Creating a new type by naming a tuple:

```rust +exec +line_numbers
struct BankAccount(String, f64);

fn main() {
    let bank_acc_david = BankAccount("David".to_string(), 939938.34);
    let bank_acc_matej = BankAccount("Matej".to_string(), 23.);

    print_acc(bank_acc_david);
    print_acc(bank_acc_matej);
}

fn print_acc(account: BankAccount) {
    println!("Account: {}, amount: {}", account.0, account.1);
}
```

Type System - Named Structs
===
Giving sensible names to struct members:

```rust +exec +line_numbers
struct BankAccount {
    name: String,
    amount: f64,
    interest_rate: f64,
}

fn main() {
    let bank_acc_david = BankAccount { name: "David".to_string(), amount: 939938.34, interest_rate: 12. };

    print_acc(bank_acc_david);
}

fn print_acc(account: BankAccount) {
    println!("Account: {}, amount: {}, interest_r: {}", account.name, account.amount, account.interest_rate);
}
```

Type System - Type Safety
===

```rust +line_numbers
struct BankAccount {
    name: String,
    amount: Amount,
    interest_rate: Interest,
}

struct Amount(f64);
struct Interest(f64);

fn main() {
    let name = "David".to_string();
    let amount = Amount(848484.);
    let interest = Interest(23.);

    let BankAccount {
        name,
        amount,
        interest_rate: interest,
    };
}
```

Type System - Enums
===

```rust
struct BankAccount {
    name: String,
    amount: Amount,
    debt_amount: Amount,
    interest_rate: Interest,
    is_credit_card: bool,
}
```

```rust
enum Card {
    Debit(u32),
    Credit { number: u32, limit: f64 },
}

struct BankAccount {
    name: String,
    amount: Amount,
    interest_rate: Interest,
    card: Card
}
```

Ownership - Static & Stack & Heap
===

```rust
const magic_numbers: [i32; 4] = [1, 2, 3, 4];

fn main() {
}
```

Ownership - Stack
===

```rust
fn main() {
    let reference = get_text();
}

// This won't compile
fn get_text<'a>() -> &'a u32 {
    let x = 4;
    &x
}
```

Ownership - Heap
===

```rust
fn main() {
    let mut x = vec![1, 2, 3, 4];
    let reference_x = &x;
    x.push(67);
    print!("{:?}", &reference_x);
}
```

Memory Errors
===

# What is a memory error?

<!-- pause -->

# What is undefined behavior?

Uninitialized Memory
===

```cpp
int x;
cout << x;
```

<!-- pause -->

```cpp
int x;

if (condition) {
    x = 10;
    return x;
} else {
    return x;
}
```

<!-- pause -->

Uninitialized Memory - Rust
===

```rust +exec +line_numbers
fn main() {
    let x;

    if true {
        x = 10;
    } else {
        println!("hello");
    }
    println!("{x}");
}

```
Nullptr Dereference
===

```cpp
string* ptr { NULL };
cout << *ptr;
```

```rust +exec +line_numbers
fn main() {
    let x: *mut String;
    println!("{}", *x);
}

```

OOB Access
===

```cpp
  int arr[3] = { 1, 2, 3 };
  cout << arr[3];
```

```rust +exec +line_numbers
fn main() {
    let x = [1, 2, 3];
    println!("{}", x[3]);
}
```

Dangling Pointers
===

```cpp
int* foo() {
    int x { 42 };
    return &x;
}
```

```rust +exec +line_numbers
fn main() {
    let _ = foo();
}

fn foo<'a>() -> &'a i32 {
    let x = 42;
    &x
}
```

Double Free
===

```cpp
void foo(SomeObject o) {
    // do stuff
} // <- freed here

int main() {
    SomeObject o;
    foo(o);
} // <- freed again
```

Double Free - Rust
===

```rust +exec +line_numbers
fn foo(value: String) {
    println!("{value}");
}

fn main() {
    let x = String::new();
    foo(x);
    println!("{x}"); // <- what happens if we comment this out?
}
```

Use after Free
===

```cpp
void foo(SomeObject o) {
    // do stuff
}

int main() {
    SomeObject o;
    foo(o); // <- freed here
    cout << o;
}
```

```rust +exec +line_numbers
fn foo(value: String) {
    println!("{value}");
}

fn main() {
    let x = String::new();
    foo(x);
    println!("{x}");
}
```

Iterator Invalidation
===

```cpp
vector<int> v = {1, 2, 3, 4, 5};
for (auto item = v.begin(); item != v.end(); ++item) {
    if (*item == 3) {
        v.push_back(42);  // <--what happes here?
    }
}
```

Iterator Invalidation - Rust
===

```rust +exec +line_numbers
fn main() {
    let mut v = vec![1, 2, 3, 4, 5];
    for item in v.iter() { // <--what happens when we use `iter_mut()`?
        if *item == 3 {
            v.push(42);
        }
    }
}
```
