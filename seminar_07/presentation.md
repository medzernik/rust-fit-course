---
title: asynchronous programming
author: David & Matej
options:
  implicit_slide_ends: true
---
Concurrency
===
<!-- incremental_lists: true -->
- working on multiple things during overlaping time segments
- aka starting work on task B before finishing task A
- parallelism is a form of concurrency
- concurrency != parallelism

Tasks
===
```rust +line_numbers +exec
fn main () {
    let data = vec![5,2,6,7,8,1,2,3];
    //             ^^^|^^^|^^^|^^^
    //                |_____each part can be worked on by a different thread

    let result = data.iter().sum::<i32>();
    println!("{result}");
}
```

How to parallelise this
===
```rust +line_numbers +exec
fn main() {
    println!("Hello, world!");
    let data = [5, 2, 4, 6, 7, 9];

    let thread_count: usize = (data.len() + 1) / 2;

    let result = (0..thread_count)
        .map(|i| (2 * i, 2 * i + 1))
        .map(|(i, j)| std::thread::spawn(|| data[i] + data[j]))
        .fold(0, |acc, handle| acc + handle.join().unwrap());

    println!("{result}")
}
```

# Some notes
- fix compilation error
- what will happen if the number of elements is odd?
- what will happen if we don’t use `div_ceil()`?

Parallelism - Advantages and Limitations
===
<!-- incremental_lists: true -->
- faster processing of certain data
- not blocking a thread already busy with tasks (rendering)
- separate call stack - panics panic a thread, not the whole program
- synchronizing state of work
- easier reprioritizng of work

Parallelism - How
===
<!-- incremental_lists: true -->
- Traits - `Send` and `Sync`
- `T` is `Send`, unless they are not
- `T` is `Sync` if `&T` is `Send`

# Send
Allows us to send something (safely) to a different thread.

<!-- pause -->
## What is not `Send`
- Some pointers (Rc, *mut, Cell, RefCell, *raw, etc...)

<!-- pause -->
# Sync
Allows us to share something between multiple threads 
- Mutex, RwLock, ...

<!-- pause -->

Mutex
===

```rust +line_numbers
let data = Arc::new(Mutex::new("hi".to_string()));

// we require successful lock here to get to the data (!)
let mut data: MutexGuard<String> = data.lock().unwrap();


*data += 1;

// done automatically when calling `}`
drop(data);
```

RwLock
===

```rust +line_numbers +exec
use std::sync::{Arc, RwLock};
fn main() {
    let data = Arc::new(RwLock::new(5));

    let mut writable_data = data.write().unwrap();

    *writable_data += 1;

    drop(writable_data);

    let read_data = data.read().unwrap();
    println!("{}", *read_data);
}
```

Channels
===
<!-- incremental_lists: true -->
 - Multiple producer single consumer - MPSC
 - Multiple producer multiple consumer - MPMC
 - *More channels are available in `tokio` async runtime*

# MPSC Example
```rust +line_numbers
// Create a simple streaming channel
let (tx, rx) = channel();

thread::spawn(move || {
    tx.send(10).unwrap();
});

assert_eq!(rx.recv().unwrap(), 10);
```

Concurrency
===
<!-- incremental_lists: true -->
- Doing multiple things on a single thread or on multiple threads.
- Rust has no runtime. You need to bring your own.
  - Most popular is `tokio`.
  - Can also be used from the OS - MacOS Grand Central Dispatch (Zed).
- Keyword `.await` and `async`.
- Not everything is compatible with `async` yet.
