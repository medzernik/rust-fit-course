---
title: concurrency and parallelism
author: Matej & David
options:
  implicit_slide_ends: true
---
Parallelism
===
<!-- incremental_lists: true -->
- doing things at once
- example is an array - parallel processing of data

```rust
fn main () {
    let vec = vec![5,2,6,7,8,1,2,3];
    //             ^^^|^^^|^^^|^^^
    //                        |___> each part can be worked on by a different thread


}
```








Concurrency
===
