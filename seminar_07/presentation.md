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

Asynchrony
===
<!-- incremental_lists: true -->
- "lack of synchrony" aka lack of predictable, predetermined, linear occurence of events
- in practice, it generally refers to occurence of events that happen at "random" (random as in random access) times
- reactions to these events generally occur outside of the main program flow (sometimes there is no real main program flow)
- reactions to these events are generally concurrent

Tasks
===
<!-- incremental_lists: true -->
- a unit of work that is executed asynchronously
- has to be driven to compeltion by an **executor**/ **runtime** that manages tasks
- "green threads" aka userspace threads
-
