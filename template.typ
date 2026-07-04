// The project function defines how your document looks.
// It takes your content and some metadata and formats it.
// Go ahead and customize it to your liking!
#import "@preview/cades:0.3.1": qr-code

#let project(title: "", authors: (), logo: none, repo-source: none, body) = {
  // Set the document's basic properties.
  set document(author: authors.map(a => a.name), title: title)
  set page(
    numbering: "I", 
    number-align: center, 
    header: context {
      if here().page() > 1{
        if calc.odd(here().page()) {
          align(left, smallcaps(title))
        }else{
          align(right, smallcaps(title))
        }
      }
    },
  )
  set text(font: "Libertinus Serif", lang: "cz")
  set heading(numbering: "1.1.")

  // Title page.
  // The page can contain a logo if you pass one with `logo: "logo.png"`.
  v(0.6fr)
  if logo != none {
    align(right, image(logo, width: 26%))
  }
  v(9.6fr)

  text(2em, weight: 700, title)

  // Author information.
  pad(
    top: 0.7em,
    right: 20%,
    grid(
      columns: (1fr,) * calc.min(3, authors.len()),
      gutter: 1em,
      ..authors.map(author => align(start)[
        *#author.name* \
        #raw(author.email)
      ]),
    ),
  )

  v(2.4fr)
  pagebreak()


  // Table of contents.
  outline(depth: 3, indent: auto, title: "Obsah")
  pagebreak()


  // Main body.
  set par(justify: true)
  
  set page(numbering: "1")
  counter(page).update(1)
  body

  
  pagebreak()
  bibliography(style: "iso-690-numeric", "works.bib", title: "Bibliografie")
  
  pagebreak()
  // The page can contain a logo if you pass one with `logo: "logo.png"`.
  // v(0.6fr)
  // if logo != none {
  //   align(right, image(logo, width: 26%))
  // }
  v(9.6fr)

  pad(
    top: 0.7em,
    "Datum kompilace: " + datetime.today().display() + linebreak() +
    "Zdrojový kód: " + repo-source+
    figure(
      link(repo-source.dest)[#qr-code(repo-source.dest, width: 2cm, color: red.darken(100%), background: white)], caption: [Source], supplement: none
    )
  )
}