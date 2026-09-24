---
title: Rust Seminar FIT 01
author: Matej & David
options:
  implicit_slide_ends: true
---

Basic Seminar Info
===

# Quick info

Zed, RustRover, and rustup should be pre-installed on images in Windows and Linux computer rooms.

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

<!-- speaker_note: this is a speaker note -->

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

# What is Rust

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

Rust Today & Features
===



Installation of Rust
===


IDEs and Editors
===



Next Slide
===

Bonus: How to open this presentation :)
===
Next Slide
===
Next Slide
===
