---
title: (Borrowing II.) Control flow and error handling
author: Matej & David
options:
  implicit_slide_ends: true
---

# Borrowing Continued

Basic rules follow:

<!-- incremental_lists: true -->

- There can be only one mutable reference at one time.
- There can be limitless immutable references at one time.
- There can't exist a mutable and immutable references at the same time.
- References must live as long as the owner.
- Memory is freed when the owner goes out of scope or calls manually `drop()`.
- Ownership can be `moved` into other scopes.

These rules are checked at compile time.

<!-- pause -->

These rules can be moved to runtime using reference checking at runtime (smart pointers, coming later).
Compile time checking can be avoided by using `unsafe`.

> [!CAUTION] Unsafe does not make anything easier!
> These rules **MUST** be upheld in `unsafe`. They cannot be bent. They must be upheld **manually** in `unsafe` Rust.

Lifetimes
===

Compile-time checking of when to free memory.

<!-- incremental_lists: true -->

- `'` Indicates the lifetime syntax.
- Syntax follows using generics: `<'a, 'b>`.
- Name after `'` can be anything, with the exception of `'static`.
- `'static` lifetime is not bound by scope.

# Will this compile?

```rust +exec +line_numbers
fn main() {
    let a = "some_string";
    let b = "some_other_string";
    let c = return_longer_str(a, b);
}

fn return_longer_str(str_a: &str, str_b: &str) -> &str {
    if str_a.len() > str_b.len() {
        str_a
    } else {
        str_b
    }
}
```

Error Handling
===

In Rust, the 2 most common scenarios are covered by enums from the `prelude`.

# Option

<!-- pause -->

A value is there, or it's not there (null).

```rust
enum Option<T> {
    Some(T),
    None,
}
```

<!-- pause -->

# Result

<!-- pause -->

A process ended successfully with a returned value, or ended with an error and returned a **different** value.

```rust
enum Result<T, E> {
    Ok(T),
    Err(E),
}
```

Advanced Pattern Matching I.
===

# if let

You can match a specific type constraint:

```rust +line_numbers
if let Some(value) = some_value {
    println!("{value}");
} else {
    //some other code here
}
```

<!-- pause -->
# let chains

You can chain these using a `let` chain:

```rust
if method_name.ident.name == sym::len
    && method_args.is_empty()
    && scrutinee.hir_id().owner.to_def_id() == method_name.hir_id.owner.to_def_id()
    && let ExprKind::Path(qpath) = scrutinee.kind
    && let Some(scrutinee_hir_id) = qpath.res_local_id()
    && let Some(mentioned_in_arm_hir_id) = mentioned_in_arm.res_local_id()
    && scrutinee_hir_id == mentioned_in_arm_hir_id {
        // code here
    }
```


Advanced Pattern Matching II.
===

# match
The keyword `match` is a supercharged `switch` from other languages.
<!-- incremental_lists: true -->
- It is exhaustive (compiler enforced).
- It does a `break` by default.
- Matching is done using patterns.

<!-- pause -->
```rust
enum GetterError {
    InvalidRequest,
    NetworkError,
    GenericError(String)
}

fn main() {
    let result: Result<String, GetterError> = get_data();
    if let Ok(res) = result {
        println!("{res}");
    } else {
        panic!("fatal error");
    }
}

fn get_data() -> Result<String, GetterError> {
    let some_value = db.get("something");

    match some_value {
        Ok(value) => Ok(value),
        Err(_) => Err(GetterError::GenericError("cannot get data".to_string()))
    }

}
```

Advanced Pattern Matching III.
===
The matching on options/results can be simplified:
```rust
enum GetterError {
    InvalidRequest,
    NetworkError,
    GenericError(String)
}

fn main() {
    let result: Result<String, GetterError> = get_data().unwrap();
    println!("{result}");
}

fn get_data() -> Result<String, GetterError> {
    db.get("something").map_err(|_| Err(GetterError::GenericError("cannot get data".to_string())))?
}
```

Error Handling in Rust 
===

<!-- incremental_lists: true -->
- Error handling is done through `enum`s and is also passed by value.
- There are no `try` nor `expect` or `catch` keywords. 


Caveats of Error Handling I.
===

# Error handling

<!-- incremental_lists: true -->
- Error enums need to convert between each other to allow for `?` to work.
- To lose information and convert error enums to a simple enum, use the crate `anyhow`.
- To not lose information, but derive impl for conversions, use the crate `thiserror`.
- Both ways have their tradeoffs.

<!-- pause -->

# anyhow
From official documentation example: 

```rust
fn get_cluster_info() -> anyhow::Result<ClusterMap> {
    let config = std::fs::read_to_string("cluster.json")?;
    let map: ClusterMap = serde_json::from_str(&config)?;
    Ok(map)
}
```


<!-- pause -->
Caveats of Error Handling II.
===

# thiserror
From official documentation example: 

```rust
use thiserror::Error;

#[derive(Error, Debug)]
pub enum DataStoreError {
    #[error("data store disconnected")]
    Disconnect(#[from] io::Error),
    #[error("the data for key `{0}` is not available")]
    Redaction(String),
    #[error("invalid header (expected {expected:?}, found {found:?})")]
    InvalidHeader {
        expected: String,
        found: String,
    },
    #[error("unknown data store error")]
    Unknown,
}
```

Project - get a trams/stops from Golemio API and print departures of a stop
===

We will need:
- serde
- serde_json
- serde_toml
- clap
- thiserror
- reqwest

Let's try to program this!
