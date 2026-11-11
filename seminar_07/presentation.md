---
title: asynchronous programming
author: David & Matej
options:
  implicit_slide_ends: true
---


News
===
<!-- incremental_lists: true -->
- The subject is APPROVED AND LIVE ON KOS
- GO SIGN UP
- 5 credits, Z + ZK
- for both I. and II. level of studies

Concurrency
===
<!-- incremental_lists: true -->
- working on multiple things during overlaping time segments
- aka starting work on task B before finishing task A
- parallelism is a form of concurrency
- concurrency != parallelism


![image:width:100%](presentation/polling_detail.png)

Asynchrony
===
<!-- incremental_lists: true -->
- "lack of synchrony" aka lack of predictable, predetermined, linear occurence of events
- in practice, it generally refers to occurence of events that happen at "random" (random as in random access) times
- reactions to these events generally occur outside of the main program flow (sometimes there is no real main program flow)
- reactions to these events are generally concurrent

![image:width:100%](presentation/polling.png)

Tasks
===
<!-- incremental_lists: true -->
- a unit of work that is executed asynchronously
- has to be driven to compeltion by an **executor**/ **runtime** that manages tasks
- "green threads" aka userspace threads

Cooperative Multitasking
===
<!-- incremental_lists: true -->
- multitasking on most modern OSs is preemptive (the scheduler pauses a task without asking)
- in cooperative multitasking, a task is paused only at specific points programmed in the task (the task has to **yield**s execution)
- Rust's (like most other programming languages') async programming model relies on **cooperative multitasking**

Blocking and Non-blocking IO
===
<!-- incremental_lists: true -->
- IO operations (disk IO, socket IO), in general, take not-insignificant amount of time (disk reads, network calls)
- by default (in Rust, but also e.g. the most basic OS primitives) this is __blocking__ the calling thread, e.g.
  the thread is idle and does nothing while waiting for the OS to perform the operation
- even if the thread is put to sleep by the OS, we pay the price of context switch overhead
- most modern operating systems provide primitves for non-blocking (asynchronous IO)
  - either asynchrnously wait until IO is ready (`select`, `poll`, `epoll`)
  - or submit an operation and check the results later (`io_uring`)

Runtimes
===
- as mentioned, tasks need to be driven by a runtime (executor) that mostly acts as a scheduler + async IO driver
- Rust doesn't have a default runtime
- the default runtime used by most projects is [`tokio`](https://tokio.rs)
- embedded projects often use a runtime provided by [`embassy`](https://docs.rs/embassy-executor/latest/embassy_executor/)
- runtimes usually take advantage of having multiple threads and juggling tasks between threads
- runtimes are thus an abstraction over both concurrency and parallelism (usually a better one than manual work with threads)
- typically, we initialize a runtime and then spawn tasks within it

Futures
===
- Primitve of Rust's async model
- Represents a value that might not be ready yet (e.g. the value is being computed, usually because we wait on some IO in the background)
- Built on the "polling" model of async
- Represented by the `Future` trait with a single `poll` method
- the `poll` method returns `Poll::Ready(T)` or `Poll::Pending`
- the tasks we spawn in a runtime have to be `Future`s

Async Await
===
- Instead of implementing `Future`s manually, we usually use the `async` keyword that creates a `Future` for us
- we can use `async` with a block, a `fn` or a closure
- within an `async` block (or `fn` or...), we can call `.await` on other `Future`s to wait until they are ready
- calling `.await` also hands control back (yields) to the runtime, which can work on another task
- `async` desugars or function (or block) to a state machine, saving the state on each `.await`

Pin
===
- you can notice `poll` uses `Pin<&mut Self>` as the receiver of the call
-
