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
- Declarative
- Procedural
  - Functional
  - Derive
  - Attribute


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

```rust
//! my_calculator/my_calculator_derive/src/lib.rs (normal my_calculator library code would live
//! under e.g. my_calculator/my_calculator/src/lib.rs)
use proc_macro::TokenStream;
#[proc_macro_derive(MyCalculatorTrait)]
pub fn my_calculator_derive(input: TokenStream) -> TokenStream {
    // Rust code that operates on TokenStream here.
}
```
