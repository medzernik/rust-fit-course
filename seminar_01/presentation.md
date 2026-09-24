---
title: Rust Seminar FIT 01
author: Matej & David
options:
  implicit_slide_ends: true
---

Basic Seminar Info
===

# Topics

| Topic                                                               | Date (exceptions) |
|---------------------------------------------------------------------|-------------------|
| 1.  Introduction to Rust - tooling, basic syntax, modules and test  | 30. 09            |
| 2.  Type system, ownership, borrowing                               | 6.10. TUESDAY     |
| 3.  Control flow and error handling                                 | 14.10.            |
| 4.  Closures, collections, iterators                                | 21.10.            |
| 5.  Smart pointers and interior mutability                          | 27.10 TUESDAY     |
| 6.  Concurrency and parallelism                                     | 4.11              |
| 7.  Asynchronous programming - basics                               | 11.11             |
| 8.  Asynchronous programming - project using a simple reverse proxy | 18.11.            |
| 9.  Macros                                                          | 25.11             |
| 10. Unsafe, FFI and interop with C/C++                              | 2.12.             |

# ICS

![ics](presentation/FIT-REZ-ical.png)


> [!TIP]
> Zed, RustRover, and rustup should be pre-installed on images in Windows and Linux computer rooms.

Assignments
===

1. Test module – some exercises to help practice concepts
2. Homework assigment - the `/src` dir
3. Code review – all assignments should have a code review by someone else in the course
4. Group projects – final, bigger project

| Homework                                                                            | Notes                                |
|-------------------------------------------------------------------------------------|--------------------------------------|
| 1. Create a simple calculator (+,-,*,/,^,log)                                       | i32 only, div/0 mustn't panic        |
| 2. Make a serializable struct for JSON                                              |                                      |
| 2. Find the longest substring and return reference                                  |                                      |
| 3. Add error handling to the calculator                                             |                                      |
| 3. Get a trams/stops from Golemio API and print nearest departures of selected stop | https://api.golemio.cz/docs/openapi/ |
| 4. TBD                                                                              |                                      |
| 5. TBD                                                                              |                                      |
| 6. TBD                                                                              |                                      |
| 7. TBD                                                                              |                                      |
| 8. TBD                                                                              |                                      |
| 9. TBD                                                                              |                                      |
| 10.  TBD                                                                            |                                      |

Literature and Courses
===

| Book/Course                                                                                              | Notes                                                              |
|----------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------|
| [Programming Rust 3rd Edition](https://www.oreilly.com/library/view/programming-rust-3rd/9781098176228/) | Goes through everything in detail                                  |
| [Rust Locks and Atomics](https://mara.nl/atomics/)                                                       | Deep dive into internals of async/parallel                         |
| [The Rust Programming Language](https://doc.rust-lang.org/book/title-page.html)                          |                                                                    |
| [Write Powerful Rust Macros](https://www.manning.com/books/write-powerful-rust-macros)                   | Expert-level topics                                                |
| [Rust for Rustaceans](https://rust-for-rustaceans.com)                                                   | Intermediate book                                                  |
| [Rustlings](https://rustlings.rust-lang.org)                                                             | Built into RustRover                                               |
| [Crust of Rust](https://www.youtube.com/playlist?list=PLqbS7AVVErFiWDOAVrPt7aYmnuuOLYvOa)                | In-depth channel                                                   |
| [Exercism Rust](https://exercism.org/tracks/rust)                                                        | Nonprofit - mostly leetcode tasks                                  |
| [Codecrafters](https://app.codecrafters.io/catalog)                                                      | Paid but with a rotating free challenge monthly, advanced projects |
| [Rust Reference](https://doc.rust-lang.org/reference/)                                                   |                                                                    |
| [Docs](https://docs.rs)                                                                                  |                                                                    |

Seminar_01 – About Rust
===
<!-- column_layout: [1, 1] -->
<!-- column: 0 -->
[Rust Official Website](https://rust-lang.org)

# What’s Rust

- The [most loved](https://survey.stackoverflow.co/2025/technology#admired-and-desired) general-purpose programming
  language
- Initially designed for system programming
    - nowadays used also for web apps, games, etc.
- Compiled, statically typed, strongly typed, language.
- Utilizes RAII
- Memory safe
    - compile-time checking of memory issues
- Multi-paradigm language
    - procedural
    - functional (strongly inspired by functional languages)
    - object-based (no inheritance, but has subtyping)
- It's *really* fast
    - has a minimal runtime
    - no garbage collection
    - ~zero-cost abstractions
- Great backwards compatibility
- Fantastic compiler error messages

<!-- column: 1 -->
![](presentation/fastest-elapsed.png)
![](presentation/fastest-more-elapsed.png)

[](https://benchmarksgame-team.pages.debian.net/benchmarksgame/box-plot-summary-charts.html)



Where is Rust Used?
===

<!-- column_layout: [1, 1] -->
<!-- column: 0 -->

# Companies using Rust

- Microsoft
- Discord
- Mozilla
- Google (Android)
- Linux
- Toyota
- Dropbox
- Atlassian
- 1Password
- Cloudflare
- JetBrains
- Figma
- AWS

<!-- column: 1 -->

# Current Adoption Numbers

![](presentation/rust-adoption.png)
[](https://devecosystem-2025.jetbrains.com/tools-and-trends)

History
===
<!-- column_layout: [1, 1] -->
<!-- column: 0 -->

# 2006

- Created in Mozilla by *Graydon Hoare*

> "I think I named it after fungi… that is "over-engineered for survival."
> *\- Graydon Hoare*

# 2010 - 2015

- Project Servo
- Early experiments
- Originally had GC, was class-based
- `0.11.0` caused some changes that may explain today's syntax
    - ~[T] has been removed from the language. This type is superseded by the Vec type.
    - ~str has been removed from the language. This type is superseded by the String type.
    - ~T has been removed from the language. This type is superseded by the Box type.
    - @T has been removed from the language. This type is superseded by the standard library’s std::gc::Gc type.
- [Rust testcases over time](https://brson.github.io/archaea/)
- [A look from 2012](https://purplesyringa.moe/blog/a-look-at-rust-from-2012/)
- [Evolution of compiler errors](https://kobzol.github.io/rust/rustc/2025/05/16/evolution-of-rustc-errors.html)

> Rust is a curly-brace, block-structured expression language that looks similar to C and C++ and allows developers to
> write code that behaves well in large and concurrent systems.
> [](https://www.i-programmer.info/news/98/6074.html)


<!-- column: 1 -->

![](presentation/rustinfo-0-4.jpg)
> Someone recently quipped that if you can hang yourself with one pointer then three distinct types should do the job in
> far less time
> *[](https://www.i-programmer.info/news/98-languages/5042-rust-04-full-integration-of-borrowed-pointers.html)*

# 2015

- Rust 1.0
- [MIR](https://blog.rust-lang.org/2016/04/19/MIR/)

Rust Versioning
===

# Versioning

Rust is released every 6 weeks.

- stable
- beta
- nightly

Installation is done using a separate tooling script `rustup`. We’ll look at this a little later.

## Compiler versions vs. Editions

Aside from the regular releases, Rust also releases `Editions`. There’s usually an edition released every 3 years.
Currently, there are `2015`, `2018`, `2021` and `2024` editions of Rust available.

Editions introduce breaking changes into the language.

This is possible to keep separate from the compiler updates due to the design of the compiler and
language, [as seen here](https://blog.rust-lang.org/2018/07/27/what-is-rust-2018/#managing-compatibility)

Most importantly:
> Anything that doesn’t require being a part of Rust 2018 will work on Rust 2015 as well. This is due to the way
> editions work; given the small nature of possible changes, the compiler uses the same internal representation for all
> editions.

It’s a standard practice to keep your Rust toolchain updated to the latest `stable` version, even in production.

Installing Rust I.
===

# Installing the Linker

> [!IMPORTANT]
> Rust doesn’t have a linker. This means you have to install a linker yourself.

## Windows - Installing the linker

If we’re on MS Windows, we’ll need to first install the `MS Build Tools`, available also from
the [link here](https://aka.ms/vs/stable/vs_BuildTools.exe)

After installing the Build Tools, we need to make sure we select the entire C/C++ compiler group, and also using the
`Individual Packages` UI insert the `platform latest spectre` search term, then pick the resulting spectre safe
libraries

> [!TIP]
> Rust takes a long time to compile. To make this about 1/3rd faster on Windows, you can set up a **Dev Drive**.
> Follow the instructions [on the Microsoft page](https://learn.microsoft.com/en-us/windows/dev-drive/) if you wish to
do so. Note that you need to make a separate partition of a minimum 50GB. You can shrink an existing NTFS partition
while it's online. The **DevDrive** partition will use ReFS and Windows Defender will work in a deferred async scan mode
to make compilation a lot faster.

## Linux

Install the `build-essentials` package on Ubuntu/Debian/Mint (or your distribution equivalent).

## macOS

Install the xcode-command line build tools

Installing Rust II.
===

# Installing Rust

After we install the linker, we can download the `rustup` installer `.exe` and use it to setup the toolchain. `rustup`
will serve as our Rust package manager

We can find `rustup` on the webpage [rustup.rs](https://rustup.rs)
or [rust-lang.org](https://rust-lang.org/tools/install/)

That's it! You can open up a new terminal window after it's installed and try to run

```bash +exec 
cargo --version
```

We’ll look into Cargo a little later.

> [!TIP] Rust Playground
> You can use the [Rust Playground](https://play.rust-lang.org) to test out your Rust snippets, share them and even run
> Miri and expand macros!

Build system - Cargo
===

- An amazing build system
- Integrated documentation builder
- Integrated dependency resolution
- Uses a central registry [crates.io](https://crates.io)
    - can use other, private registries as well
- Uses `.lock` files to pin dependencies

IDEs and Editors I.
===

There are many great editors to choose from. Rust has a fantastic LSP `rust-analyzer` that should integrate within
almost any editor. Our recommendations are `Zed`, `Helix` or `RustRover`.

# Zed

Zed offers collaborative features and fast performance. It’s a multi-language editor, focused on speed. It has an
**integrated debugger**, **terminal**, **basic git support**. It has advanced **remote development features**, including
support for `WSL2` and SSH into other machines. Zed also has a great `Helix` and `Vim` modes.

You can get Zed on the page [zed.dev](https://zed.dev)

# Helix

Helix is a terminal editor, similair to `NeoVim` that has a focus on speed and uses `Kakoune` inspired keybinds. It’s
significantly easier to learn than `Vim`, but the motions aren’t transferable easily.

Helix is available ideally using either `WinGet` on Windows, or `brew install helix` on macOS and Linux. Distribution
repos may have an outdated version of Helix.
> [!NOTE]
> Helix has an incomplete debugger protocol (DAP) support. Debugging may be complicated but should be possible.

> [!IMPORTANT]
> When using **NeoVim**, **Helix** or other more obscure editors, you need to install **rust-analyzer** yourself.
> You can do so by running the command:
> **$ rustup component add rust-analyzer**
> The reason for this is that **Zed** and **VSCode** all automatically pull in the LSP separately from the toolchain
> when launched.

IDEs and Editors II.
===

# RustRover

RustRover is a fully fledged IDE, available for free for non-commercial use, and also available for free for students.

> [!NOTE]
> RustRover uses its own parsing engine and custom-built analysis. You can learn
more [in this YouTube video](https://youtu.be/VbdD1c3owKc)

Compared to `rust-analyzer`, RustRover analysis engine can help with:

- Cargo.toml file support
- Cargo command runner
- advanced Rust debugger including support for embedded targets and remote debugging
- declarative macro tester
- built-in procedural macro expansion
- Rust REPL frontend
- actix/reqwest web framework endpoint support
- Cargo test support including highligts of lines where tests failed
- database client
- lifetime highlighting
- full-featured Git/subversion/other VCS clients
- advanced refactoring
- unsafe blocks highlighting
- and much more :D

Cargo
===

<!-- column_layout: [1, 1] -->
<!-- column: 0 -->
Maybe even better than Rust. Allows you to manage your Rust projects.

# Creating a project

$ cargo new \<name>

$ cargo init \<name>

# Managing dependencies

$ cargo add \<dep>

$ cargo remove \<dep>

$ cargo update

$ cargo install \<dep>

# Formatting, checking and building the project

$ cargo fmt

$ cargo check

$ cargo clippy

$ cargo run

$ cargo build

$ cargo test

$ cargo doc
<!-- column: 1 -->

> [!TIP] clippy
> Clippy is the official Rust linter. It can check for various patterns that aren’t considered best practice. We use
> Clippy regulary as a CI tool in 'warnings as errors' mode in production

> [!TIP] fmt
> Rust has a formatter tool that formats the code in a standardized way. Use this tool each time you publish your
> solution anywhere, as usually it's part of CIs

> [!TIP] automating running of tasks
> To automate all generic tasks, we recommend the tool [bacon](https://dystroy.org/bacon/). It allows you to easily run
> check, build and test tools. You can also use RustRover's built in toolset, or automate using Tasks in **Zed** or
> VSCode.

> [!TIP] doc
> Rust also has an integrated documentation tool. You can see the documentation formatted using this tool almost
> everywhere online.

Basic Syntax
===

Rust has a simple Hello World! example:

```rust +exec
fn main() {
    println!("Hello, world!");
}
```

*However...*

```rust
#![feature(prelude_import)]
extern crate std;
#[prelude_import]
use std::prelude::rust_2024::*;
fn main() {
    {
        ::std::io::_print(format_args!("Hello, world!\n"));
    };
}
```

> [!TIP] Expanding Macros
> You can expand macros using the '$ cargo expand' tool, which you can install using '$ cargo install cargo-expand'

Taking the example apart
===

# Function declaration

```
fn main() {}──►
```

```
fn main() {}
^^ ^^^^^^ ^^-- function body starts on existing line (K&R style)
|  |
|  |__________ function name and arguments       
|  
|_____________ function declaration   
```

Next Slide
===

Error Messages
===

Next Slide
===

Next Slide
===

Next Slide
===

Next Slide
===

Bonus: How to open this presentation :)
===
Next Slide
===
Next Slide
===
