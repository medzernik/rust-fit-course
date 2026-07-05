#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.1": *
#import "@preview/lilaq:0.6.0" as lq
#show: codly-init.with()
#codly(zebra-fill: none)
// #codly(languages: codly-languages, highlight-radius: 0cm, radius: 0cm, lang-radius: 0cm)
#codly(languages: codly-languages)
#import "src-syllabus/courses/template.typ": *
// Take a look at the file `template.typ` in the file panel
// to customize this template and discover how it works.
#show: project.with(
  title: "skripta_template_rust",
  authors: (
    (name: "aa, bb", email: "a@b.xyz"),
  ),
  logo: "cuddlyferris.svg",
  repo-source: link("https://github.com/todo()!")[github.com/todo()!],
)

// We generated the example code below so you can see how
// your document will look. Go ahead and replace it with
// your own content!

// = Introduction
// #lorem(60)
// #codly(languages: codly-languages, highlights: ((line: 2, start: 0,tag: [ Highlight ]),))
// ```rust
// pub fn main() {
//     println!("Hello, world!");
// }
// ```
// #codly(header: [*Hello, world!*],
//   annotations: (
//     (
//       start: 2,
//       end: 4,
//       content: block(
//         width: 2em,
//         // Rotate the element to make it look nice
//         rotate(
//           -90deg,
//           align(center, box(width: 100pt)[Function body])
//         )
//       )
//     ),
//   )
// )
// ```rust
// pub fn main() {
//     abc
//     println!("Hello, world!");
//     def
// }
// ```


// #figure(
//   image("cuddlyferris.svg", width: 30%),
//   caption: [A nice figure!],
// )
// #let x = lq.linspace(0, 10)
// #let y = x.map(x => calc.sin(0.1 * x * x))
// #figure(
//   lq.diagram(
//     lq.plot(x, y),
//     lq.plot(x, x => calc.sin(x + 0.541))
//   ),
//   caption: [An example graph #cite(<Nobody06>)]
// )

// //

= Úvod

= Inicializace
== Instalace Rust a Rust-analyzer
== Cargo
== IDE
=== První program / `Hello, world!`
```bash
cargo init hello-world
cd hello-world
cargo run
```
// #codly(highlights: ((line: 1, start: 11),(line: 4, start: 11),(line: 5, start: 11),))
```
bash-5.3$ cargo init hello-world
    Creating binary (application) package
note: see more `Cargo.toml` keys and their definitions at https://doc.rust-lang.org/cargo/reference/manifest.html
bash-5.3$ cd hello-world/
bash-5.3$ cargo run
   Compiling hello-world v0.1.0 (/Users/stefus/Programming/hello-world)
    Finished `dev` profile [unoptimized + debuginfo] target(s) in 0.48s
     Running `target/debug/hello-world`
Hello, world!
```
#codly(header: [Cargo.toml])
```toml
[package]
name = "hello-world"
version = "0.1.0"
edition = "2024"

[dependencies]
```
#codly(header: [src/main.rs])
```rust
fn main() {
    println!("Hello, world!");
}
```


= Proměnné
== Mutabilita
== Shadowing
== Primitivní datové typy
=== Text
=== Čísla
=== Konverze
== Základní kontajnery
=== Array
=== Vector

= Ownership
== Vlastnictví
== Borrow-checker
== `clone()`
== Lifetimes

= Reference
== Počítání referencí
== Fat pointer/Slice

= Flow control
== `enum`
=== `Option`
=== `Result`
== `if`
== `match`
=== `todo!()`
=== `unreachable!()`
== `while`
== `for`
== `if` / `while` / `for - let`
== `unwrap()`

= Funkce
== Vstupy
== Návratové hodnoty
=== `Result`, `Option`, `?`
=== Pattern: kdy použít `Option`/`Err(std::io::error)` a kdy použít vlastní `enum`
=== Turbofish `::<>`

= `Cargo.toml`
== `Crate`
== `Module`
== `Workspace`

= `struct`
== `#[derive(...)]`
== `impl`
=== Generics
=== Operator overloading
== Seznam `traits`

= `closure`
== `move ||`

= Iteratory
== `collect()`
== `map()`
== `filter()`

= Lifetime
== `'static`

= Zpracování řetězců
== `Split()`, `Split_at()`
== `stdio`
== Práce se soubory

= `channel`
== `mpsc`
== `tokio::unbounded_channel`
== `tokio::Broadcast`
== `tokio::oneshot`
== `tokio::watch`

= Concurrency
== `thread`
== `command`
== `await()`
== `bufreader` / `bufwriter`
== `async`
== `future`
== `dyn` // todo: maybe move to traits

= Testování
== Unit testy
== `insta` crate
== `criterion` crate
== `cargo-lippy` / linter

= Komunikace se sítí
== `tokio::TcpListener`

= Makra
== `derive`
== `recursive`
== `expand`

= `unsafe`
== FFI
== raw pointer
== traits
== `union`
== `miri`
== Rustonomicon
