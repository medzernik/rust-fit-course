#import "@preview/diatypst:0.9.3": *
#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node
#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.1": *
#import "@preview/lilaq:0.6.0" as lq
#import "@preview/cades:0.3.1": qr-code
#show: codly-init.with()
#codly(zebra-fill: none)
#set text(lang: "cz")
#set page(
  footer: none,
  header: none,
  margin: 0cm,
  height: 10.5cm, // height is either 9cm, 10.5cm or 12cm
  width: 16 / 9 * 10.5cm, // width is your height * your ratio
)

//DO NOT FORGET TO SET!!!!
#let permalink = "https://typst.app"
#let issue_tracker_permalink = "https://typst.app/todo/issue_tracker_permalink"
#let source_code_link = "https://typst.app/todo/source-sode"

// Custom First Slide:
#block(
  inset: (top: 0.8cm, bottom: 0.4cm, x: 0.8cm),
  fill: red.darken(50%),
  width: 100%,
  height: 60%,

  //permalink
  //align(right, qr-code(permalink, width: 2cm, color: red.darken(70%), background: white))+
  //permalink

  align(bottom)[
    #text(2.0em, weight: "bold", fill: white)[Programování v Rustu]
  ],
)
#block(
  height: 30%,
  width: 100%,
  inset: (top: 0cm, bottom: 0.3cm, x: 0.8cm),
  text(1.4em, fill: red.darken(50%), weight: "bold", "01.: Úvod do předmětu")
    + linebreak()
    + text(1.1em, "date-todo!()")
    + align(right, image("cuddlyferris.svg", height: 80%))
    + align(bottom)[authors todo!()],
)

#show: slides.with(
  title: "Programování v Rustu", // Required
  subtitle: "Úvod do předmětu",
  date: "2026-04-22",
  authors: "name todo <email@todo>",

  // Optional (for more see docs at https://mdwm.org/diatypst/)
  ratio: 16 / 9,
  layout: "medium",
  title-color: red.darken(50%),
  toc: false,

  first-slide: false,

  theme: "normal",
  count: "number",
)
#outline(depth: 3, indent: auto, title: "Obsah")

// `=`  je nova kapitola
// `==` je novy slide

= code snippets
== code snippets
#codly(languages: codly-languages, highlights: ((line: 2, start: 0, tag: [ Function body ]),))
```rust
pub fn main() {
    println!("Hello, world!");
}
```

= Motivace
== Otázky <last>

/ Q&A: Čas na otázky!

#align(
  bottom,
  figure(
    link(permalink)[#qr-code(permalink, width: 2cm, color: red.darken(100%), background: white)],
    caption: [Prezentace],
    supplement: none,
  )
    + "Datum kompilace: "
    + datetime.today().display()
    + linebreak()
    + "Zdrojový kód: "
    + permalink,
)
