---
title: macros
author: Matej & David
options:
  implicit_slide_ends: true
---

News
===

- The subject is now full (96)
- Homework
- Rust 1.100
  - Never (!) type
  - Custom Drop functions
  - Allocator API
  - Cargo min-publish size


Macros
===
- Declarative `custom!()`
- Procedural
  - Functional `function!()`
  - Derive `#[derive(DeriveAtt)]`
  - Attribute `#[CustomAttribute]`


Why macros
===

<!-- incremental_lists: true -->
- When we cannot achieve what we want using language features
  - when polymorphism fails
  - when dynamic dispatch fails
  - etc...
- Variable arguments
- Expanding macros conditionally

# Materials
- Little Book of Rust Macros
- Programming Rust 3rd edition
- Write Powerful Rust Macros

```rust
let students = Json::Array(vec![
    Json::Object(Box::new(vec![
        ("name".to_string(), Json::String("Jim Blandy".to_string())),
        ("class_of".to_string(), Json::Number(1926.0)),
        ("major".to_string(), Json::String("Tibetan throat singing".to_string())),
    ].into_iter().collect())),
    Json::Object(Box::new(vec![
        ("name".to_string(), Json::String("Jason Orendorff".to_string())),
        ("class_of".to_string(), Json::Number(1702.0)),
        ("major".to_string(), Json::String("Knots".to_string())),
    ].into_iter().collect())),
]);
```

<!-- pause -->

```rust
let students = json!([
    {
        "name": "Jim Blandy",
        "class_of": 1926,
        "major": "Tibetan throat singing"
    },
    {
        "name": "Jason Orendorff",
        "class_of": 1702,
        "major": "Knots"
    }
]);
```

Declarative macros
===
Example macro:

```rust
assert_eq!(gcd(6, 10), 2);
```

<!-- pause -->

```rust
match (&gcd(6, 10), &2) {
    (left_val, right_val) => { // <-- pattern
        if !(*left_val == *right_val) { // <-- template
            panic!("assertion `left == right` failed\
            \n left: {left_val:?}\
            \n right: {right_val:?}",
            );
        }
    }
}
```

Vec Macro
===

```rust
// New empty Vec
let unicorns = vec![];
// Repeat a value N times
let buffer = vec![0_u8; 1000];
// A list of values, separated by commas
let noodles = vec!["udon", "ramen", "soba"];
```

<!-- pause -->

```rust
macro_rules! vec {
    () => {
        ::std::vec::Vec::new()
    };
    ($elem:expr ; $n:expr) => {
        ::std::vec::from_elem($elem, $n)
    };
    ( $( $x:expr ),* ) => {
        <[_]>::into_vec(Box::new([ $( $x ),* ]))
    };
}
```

Declarative Constants
===
- block: a block (i.e. a block of statements and/or an expression, surrounded by braces)
- expr: an expression
- ident: an identifier (this includes keywords)
- item: an item, like a function, struct, module, impl, etc.
- lifetime: a lifetime (e.g. 'foo, 'static, …)
- literal: a literal (e.g. "Hello World!", 3.14, '🦀', …)
- meta: a meta item; the things that go inside the #[...] and #![...] attributes
- pat: a pattern
- path: a path (e.g. foo, ::std::mem::replace, transmute::<_, int>, …)
- stmt: a statement
- tt: a single token tree
- ty: a type
- vis: a possible empty visibility qualifier (e.g. pub, pub(in crate), …)

Procedural Macros
===
- code-in -> transform -> code-out
- more specifically, modifications of a `TokenStream`: `f(TokenStream) -> TokenStream`
- 3 kinds
  - derive macros (`#[derive(...)]`)
  - attribute-like (`#[must_use()]`, `#[cfg(test)]`,...)
  - function-like
    - similar to `macro_rules!` declarative macros, but more powerful (and harder to write)
    - invoked using the `!` syntax like declarative macros
    - defined using `#[proc_macro]` attribute on a `pub fn` that takes `TokenStream` as both an input and an output

Working with Procedural Macros
===
- Proc macros are defined using regular Rust code.
- Proc macro definitions **must** live in their own crate. Typically it is a separate package in a workspasace.
  - The proc macro crate is of a special type (limitation of the `cargo` build system, maybe will be removed in future)
  - Different types of proc macros can be defined in the same crate.
  - Very often we use `syn` (3rd party parser) for parsing the `TokenStream` into an AST...
  - ... and `quote` for turning "quasi-Rust" code (code that needs interpolating... see later example) into a `TokenStream`
  - typical flow: parse into AST, extract data from AST (identifiers, members, type names...) and interpolate them
    into quasi Rust notated code, then convert it back to a `TokenStream`.
  - note: `syn` and `quote` use `proc_macro2::TokenStream` - a wrapper around the native `TokenStream`. You
    can read on motivations for a wrapper [here](https://docs.rs/proc-macro2/latest/proc_macro2/). It converts
    automatically from/to the native `TokenStream`.

```rust
//! my_calculator/my_calculator_derive/src/lib.rs (normal my_calculator library code would live
//! under e.g. my_calculator/my_calculator/src/lib.rs)
use proc_macro::TokenStream;
#[proc_macro_derive(MyCalculatorTrait)]
pub fn my_calculator_derive(input: TokenStream) -> TokenStream {
    // Rust code that operates on TokenStream here.
}
```

Derive Macros
===
- It is useful to expose automatic derivations of our `Trait`s if it is possible.
- We need to "write" an implementation for the users's struct - the struct (its source code lexed into tokens)
  is handed to us in the input `TokenStream`.

```rust
//! my_calculator/my_calculator_derive/src/lib.rs
use proc_macro::TokenStream;
use quote::quote;

#[proc_macro_derive(MyCalculatorTrait)]
pub fn my_calculator_derive(input: TokenStream) -> TokenStream {
    // Parse the tokens into an AST
    let ast = syn::parse(input).unwrap();

    // Get the name of the struct.
    let struct_name = &ast.ident;

    // Interpolate it into our quasi-Rust code
    let interpolated = quote! {
        impl MyCalculatorTrait for #struct_name {
            fn do_calculations() {
                // implementation of the trait goes here.
                
                // we can turn the name of the struct into a String and use e.g. in Serializers
                // or whenever we need to store the name of the type as a String.
                let name_of_the_struct = stringify!(#name);
            }
        }
    }

    // Convert back to a `TokenStream`.
    interpolated.into()
}
```

Attribute Macros
===
- very similar to derive macros
- used for creating custom attributes

Refresher on attributes:
```rust
#[derive(thiserror::Error, Debug)]
enum MyError {
    #[error("Lorem Ipsum Dolor: {0}")] // <- This is an attribute.
    ExtremelyGenericError(u8);
}
```

The definition takes 2 input `TokenStreams`
- 1 for the item marked with the attribute
- 1 for the attribute itself

```rust
#[proc_macro_attribute]
pub fn error(attr: TokenStream, item: TokenStream) -> TokenStream {
    // Do whatever magic you need to do here.
}
```
