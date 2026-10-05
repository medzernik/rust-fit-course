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

fn print_acc(bank_name: (&str, f64)) {
    println!("Account: {}, amount: {}", bank_name.0, bank_name.1);
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

fn print_acc(bank_name: BankAccount) {
    println!("Account: {}, amount: {}", bank_name.0, bank_name.1);
}
```
Type System - Named Structs.
===
Naming the fields of the struct
