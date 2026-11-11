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


Tasks
===
<!-- incremental_lists: true -->
- a unit of work that is executed asynchronously
- has to be driven to compeltion by an **executor**/ **runtime** that manages tasks
- "green threads" aka userspace threads
- 