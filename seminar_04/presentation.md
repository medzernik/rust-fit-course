---
title: polymorphism, traits, closures, collections and iterators 
author: Matej & David
options:
  implicit_slide_ends: true
---


accidental code duplication - when two types behave similarly
===

```rust
struct Rectangle {
    a: u32,
    b: u32,
}

struct Square {
    a: u32
}

impl Rectangle {
    fn area(&self) -> u64 {
        a*b
    }
}

impl Square {
    fn area(&self) -> u64 {
        a*a
    }
}
```

using Traits to describe (and decouple) behavior
===
```rust
trait Area {
    fn square(&self) -> u64;
}

impl Area for Rectangle {
    // we must upkeep the trait definitions
    fn area(&self) -> u64 {
        a*b
    }
}

impl Area for Square {
    // we must upkeep the trait definitions
    fn area(&self) -> u64 {
        a*b
    }
}
```

polymorphism - relying on behavior instead of data
===
```rust
enum Option<T> {
    Some(T),
    None
}

fn calculate_areas<T: Area>(&T) -> u64 {}
```

generics - static polymorphism
===


generic functions
===

generic types
===

generic impls
===

monomorphization - pros and cons
===

implementing a trait - generically
===

dynamic dispatch
===

# what it is

# what it costs
# when to use it
 
 
pure functions
===

function pointers
===

closures
===

FnOnce, FnMut, Fn
===

move ||
===

iterators
===

iterator methods ("adapters")
===

common adapters
===

composing adapters
===

performance vs loops
===

iterator traits
===
