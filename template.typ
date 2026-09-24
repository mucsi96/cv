// Awesome CV-inspired typography and layout, implemented with native Typst.
#let ink = rgb("333333")
#let muted = rgb("5d5d5d")

#let resume(first-name: "", last-name: "", position: "", photo: none, contacts: (), body) = {
  let name = first-name + " " + last-name
  set document(title: name + " — Curriculum Vitae", author: name)
  set text(font: "Source Sans 3", weight: "light", size: 9pt, fill: ink, lang: "en")
  set par(leading: 0.5em, spacing: 0.6em)
  set page(
    paper: "a4",
    margin: (x: 14mm, top: 8mm, bottom: 18mm),
    footer-descent: 5mm,
    footer: context {
      set text(size: 8pt, weight: "regular", fill: muted)
      show: smallcaps
      grid(
        columns: (1fr, auto, 1fr),
        align: (left, center, right),
        datetime.today().display("[month repr:long] [day], [year]"),
        [#name · Curriculum Vitae],
        counter(page).display("1"),
      )
    },
  )
  set heading(numbering: none)
  show heading.where(level: 1): it => block(
    width: 100%, above: 18pt, below: 9pt, sticky: true,
  )[
    #text(size: 16pt, weight: "bold")[#it.body]#h(3pt)#box(
      width: 1fr,
      line(length: 100%, stroke: 0.6pt + muted),
    )
  ]
  show strong: set text(weight: "bold")
  set list(indent: 0pt, body-indent: 4pt, spacing: 4.5pt)
  set terms(separator: h(10pt), hanging-indent: 71pt, spacing: 6pt)
  show terms: it => {
    show strong: label => box(width: 61pt)[
      #align(right, text(size: 10pt, weight: "bold", label))
    ]
    it
  }
  show link: set text(fill: ink)
  show title: set text(font: "Roboto", size: 32pt)
  show title: set block(above: 0pt, below: 3pt)

  grid(
    columns: (auto, 1fr),
    column-gutter: 12mm,
    align: horizon,
    if photo != none {
      box(width: 37mm, height: 37mm, radius: 50%, clip: true)[
        #image(photo, width: 37mm, height: 37mm, fit: "cover", alt: "Portrait of " + name)
      ]
    },
    align(right)[
      #title[
        #text(weight: "thin", fill: muted)[#first-name] #text(weight: "bold")[#last-name]
      ]
      #text(size: 7.6pt, weight: "regular")[#smallcaps(position)]
      #v(7pt)
      #set par(leading: 6pt)
      #text(font: "Roboto", size: 6.8pt, weight: "regular")[
        #contacts.map(row => row.join([ #h(5pt) | #h(5pt) ])).join(linebreak())
      ]
    ],
  )
  body
}

// Keep an entry together so its organization and role stay with its details.
#let entry(organization: "", role: "", location: "", date: "", body: []) = block(
  width: 100%,
  breakable: false,
  above: 0pt,
  below: 11pt,
)[
  #grid(
    columns: (1fr, auto),
    column-gutter: 12pt,
    row-gutter: 4pt,
    align: (left, right),
    text(size: 10pt, weight: "bold")[#organization],
    text(size: 9pt, style: "italic", fill: muted)[#location],
    text(size: 8pt, weight: "regular", fill: muted)[#smallcaps(role)],
    text(size: 8pt, style: "italic", fill: muted)[#date],
  )
  #if body != [] {
    v(5pt)
    body
  }
]
