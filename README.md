# Igor Bari — CV

A modular [Typst](https://typst.app/) CV with a self-contained template inspired
by the original Awesome CV design: Source Sans body text, a thin/bold Roboto
nameplate, monochrome ruled headings, and aligned skills and entry details.

## Build locally

Install **Typst 0.15.1**, the version pinned in CI, from the
[official releases](https://github.com/typst/typst/releases/tag/v0.15.1).
Install **Fontist 3.0.10** with Ruby 3.2 or newer:

```sh
gem install fontist --version 3.0.10
fontist update
```

Fetch the fonts declared in `fonts.yml`, then compile from the repository root:

```sh
fontist manifest install fonts.yml
mkdir -p dist
typst compile --font-path "$HOME/.fontist/fonts" --ignore-system-fonts --pdf-standard ua-1 main.typ dist/main.pdf
```

Open `dist/main.pdf` in your PDF viewer. For automatic rebuilds while editing:

```sh
typst watch --font-path "$HOME/.fontist/fonts" --ignore-system-fonts --pdf-standard ua-1 main.typ dist/main.pdf
```

## Font dependencies

[`fonts.yml`](fonts.yml) is a standard Fontist manifest listing the Source Sans 3
and Roboto styles used by the template. Fontist downloads them into its own
font directory (`~/.fontist/fonts`), outside the repository. Re-running the
install command reuses installed fonts. No font binaries are committed.

Typst selects fonts by family name; it does not download fonts named in
`set text(font: ...)`. Its documented `--font-path` option points it at the
Fontist directory. Fontist catalogs `Source Sans 3 Light` and `Roboto Thin` as
separate families, so the manifest lists them explicitly. Typst unifies these
under the base family names and selects them by weight. `--ignore-system-fonts` avoids picking
different fonts installed on the operating system.

CI installs the same pinned Fontist version and manifest, and caches the fonts
using `fontist/setup-fontist`. The manifest specifies families and styles, not
exact font-file versions; after updating font dependencies, review the PDF for
layout changes.

The template needs no external Typst packages.
PDF/UA-1 export checks document structure and image descriptions;
the PDF includes selectable text, links, section bookmarks, and document metadata.

The footer shows the build date. CI sets `SOURCE_DATE_EPOCH` to the commit
timestamp for reproducible builds. To use the same timestamp locally, run
`export SOURCE_DATE_EPOCH="$(git log -1 --format=%ct)"` before compiling.

## Edit the CV

- `main.typ`: personal details and section order.
- `template.typ`: page layout, typography, header, footer, and reusable `entry` function.
- `summary.typ`, `education.typ`, `skills.typ`, `experience.typ`,
  `open-source.typ`, `volunteering.typ`: CV content.
- `profile.jpg`: profile photo.
- `fonts.yml`: font families and styles to install with Fontist.

Use native headings, term lists, and bullet lists in section files. For an
additional position or activity, copy an `entry` call and edit its organization,
role, location, date, and optional bullet-list body. Short entries stay together
across page breaks; page flow is automatic.

## Automated PDF builds and releases

The **Build and release CV** GitHub Actions workflow compiles the CV on pull
requests and pushes to `master`. Each successful build uploads `main.pdf` as the
`cv-pdf` workflow artifact, so it can be reviewed before merging.

After a push to `master` (including a merged pull request), the workflow creates a
GitHub release with `main.pdf` attached. Release tags use
`cv-<run number>-<run attempt>`. The workflow can also be run manually from the
Actions tab; manual runs on `master` publish a release too.

Download the latest released PDF from the
[Releases page](https://github.com/mucsi96/cv/releases/latest).

## Design references

The template follows the official Typst guidance:

- [Making a template](https://typst.app/docs/tutorial/making-a-template/):
  separate content from styling and apply a template with a show rule.
- [Accessibility guide](https://typst.app/docs/guides/accessibility/):
  semantic headings and lists, document language and title, meaningful links,
  image alt text, and tagged PDF export.
- [Grid reference](https://typst.app/docs/reference/layout/grid/):
  use grids for visual layout rather than misusing data tables.
- [Setup Typst action](https://github.com/typst-community/setup-typst):
  pin the compiler version and follow its Fontist integration example.
- [Typst font discovery](https://typst.app/docs/reference/text/text/#parameters-font):
  supply downloaded fonts through `--font-path`.
- [Fontist manifests](https://github.com/fontist/fontist/blob/v3.0.10/docs/guide/manifests.md)
  and [Setup Fontist](https://github.com/fontist/setup-fontist): declare font
  requirements in YAML and install/cache them in CI.
