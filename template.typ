// A small, dependency-free template; content lives in the section files.
#let ink = rgb("333333")
#let muted = rgb("555555")
#let accent = rgb("a3293d")

#let resume(name: "", position: "", photo: none, contacts: (), body) = {
  set document(title: name + " — Curriculum Vitae", author: name)
  set text(font: "Roboto", size: 9pt, fill: ink, lang: "en")
  set par(leading: 0.5em, spacing: 0.6em)
  set page(
    paper: "a4",
    margin: (x: 16mm, top: 13mm, bottom: 18mm),
    footer: context {
      set text(size: 8pt, fill: muted)
      grid(
        columns: (1fr, auto, 1fr),
        align: (left, center, right),
        datetime.today().display("[day] [month repr:short] [year]"),
        [#name · Curriculum Vitae],
        counter(page).display("1"),
      )
    },
  )
  set heading(numbering: none)
  show heading.where(level: 1): set text(size: 14pt, fill: accent)
  show heading.where(level: 1): set block(above: 12pt, below: 6pt)
  set list(indent: 10pt, body-indent: 4pt, spacing: 2pt)
  show link: set text(fill: ink)
  show title: set text(size: 30pt, weight: "medium")
  show title: set block(above: 0pt, below: 6pt)

  grid(
    columns: (auto, 1fr),
    column-gutter: 12mm,
    align: horizon,
    if photo != none {
      box(width: 25mm, height: 25mm, radius: 50%, clip: true)[
        #image(photo, width: 25mm, height: 25mm, fit: "cover", alt: "Portrait of " + name)
      ]
    },
    align(right)[
      #title(name)
      #text(size: 10pt, fill: accent)[#position]
      #v(5pt)
      #text(size: 8pt)[#contacts.join([ #h(4pt) · #h(4pt) ])]
    ],
  )
  body
}

// Keep an entry together so its organization and role stay with its details.
#let entry(organization: "", role: "", location: "", date: "", body: []) = block(
  width: 100%,
  breakable: false,
  above: 0pt,
  below: 8pt,
)[
  #grid(
    columns: (1fr, auto),
    column-gutter: 12pt,
    row-gutter: 3pt,
    align: (left, right),
    strong(organization),
    text(size: 8pt, fill: muted)[#date],
    text(size: 8.5pt)[#role],
    text(size: 8pt, fill: muted)[#location],
  )
  #if body != [] {
    v(3pt)
    body
  }
]
