On windows MiKTeX is needed to build the pdf.
On Mac it can be installed using `brew install --cask miktex-console`

## Automated PDF builds and releases

The **Build and release CV** GitHub Actions workflow compiles `main.tex` with
XeLaTeX on pull requests and pushes to `master`. Each successful build uploads
`main.pdf` as the `cv-pdf` workflow artifact, so it can be reviewed before merging.

After a push to `master` (including a merged pull request), the workflow creates a
GitHub release with `main.pdf` attached. Release tags use
`cv-<run number>-<run attempt>`. The workflow can also be run manually from the
Actions tab; manual runs on `master` publish a release too.

Download the latest released PDF from the repository's
[Releases page](https://github.com/mucsi96/cv/releases/latest).
