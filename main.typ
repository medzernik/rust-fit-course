#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.1": *
#import "@preview/lilaq:0.6.0" as lq
#show: codly-init.with()
#codly(zebra-fill: none)

#import "template.typ": *
// Take a look at the file `template.typ` in the file panel
// to customize this template and discover how it works.
#show: project.with(
  title: "skripta_template_rust",
  authors: (
    (name: "John Doe", email: "john@gmail.com"),
    (name: "John Doe 2", email: "john2@gmail.com"),
    (name: "John Doe 2", email: "john2@gmail.com"),
    (name: "John Doe 2", email: "john2@gmail.com"),
  ),
  logo: "cuddlyferris.svg",
  repo-source: link("https://github.com/todo()!")[github.com/todo()!],
)

// We generated the example code below so you can see how
// your document will look. Go ahead and replace it with
// your own content!

= Introduction
#lorem(60)
#codly(languages: codly-languages, highlights: ((line: 2, start: 0,tag: [ Highlight ]),))
```rust
pub fn main() {
    println!("Hello, world!");
}
```
#codly(header: [*Hello, world!*],
  annotations: (
    (
      start: 2,
      end: 4,
      content: block(
        width: 2em,
        // Rotate the element to make it look nice
        rotate(
          -90deg,
          align(center, box(width: 100pt)[Function body])
        )
      )
    ), 
  )
)
```rust
pub fn main() {
    abc
    println!("Hello, world!");
    def
}
```


#figure(
  image("cuddlyferris.svg", width: 30%),
  caption: [A nice figure!],
)
#let x = lq.linspace(0, 10)
#let y = x.map(x => calc.sin(0.1 * x * x))
#figure(
  lq.diagram(
    lq.plot(x, y),
    lq.plot(x, x => calc.sin(x + 0.541))
  ),
  caption: [An example graph #cite(<Nobody06>)]
)

//

= Initializace
== Instalace Rust a Rust-analyzer
== Cargo
== IDE

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
== `while`
=== `unwrap()`
=== `todo!()`
=== `unreachable!()`
== `for`
== `if` / `while` / `for - let`

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
== `bufreader`/`bufwriter`
== `async`
== `future`
== `dyn` // todo: maybe move to traits

= Testování
== Unit testy
== `insta` crate
== `criterion` crate

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