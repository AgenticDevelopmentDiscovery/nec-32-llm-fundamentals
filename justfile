# nel-course — three Markdown registers per section, three outputs.
#
# Each section is a triple: `<name>.prose.md` (document + website),
# `<name>.slidecontent.md` (presentation), `<name>.concepts.md` (spine, never
# rendered). `just doc` and `just site` build from `sections/*.prose.md`;
# `just slides` builds from the separate `sections/*.slidecontent.md`, written
# for the slide medium — talking points and figures, not reflowed paragraphs.
#
# There is no engine and no generator: each file list is a shell glob, so the
# numeric prefixes on the section filenames ARE the order in every output. Add
# a section by adding a numbered triple; nothing needs to be registered
# anywhere.
#
# CI runs these same recipes (see .github/workflows/pages.yml), so there is one
# definition of how each output is built and no second copy to drift.

outdir := "output"
site   := "_site"
pandoc := "pandoc"
engine := "xelatex"

# `open` is macOS. On Linux:  just open=xdg-open view-doc
open   := "open"

# Shared across all three outputs.
common := "--metadata-file=metadata.yaml --resource-path=.:figures --citeproc --bibliography=references.bib"

# Print available recipes (default).
default:
    @just --list

# Build all three outputs.
build: doc slides site

# --- Document ---------------------------------------------------------------

# output/document.pdf — the long-form read.
doc:
    mkdir -p {{outdir}}
    {{pandoc}} sections/*.prose.md {{common}} \
        --pdf-engine={{engine}} \
        --toc --toc-depth=2 --number-sections \
        -V documentclass=article -V fontsize=11pt -V geometry:margin=1in \
        -o {{outdir}}/document.pdf

# --- Presentation -----------------------------------------------------------

# output/slides.pdf — built from `*.slidecontent.md`, not `*.prose.md`. Every
# `##` heading becomes one slide.
slides:
    mkdir -p {{outdir}}
    {{pandoc}} sections/*.slidecontent.md {{common}} \
        --pdf-engine={{engine}} \
        -t beamer --slide-level=2 \
        -o {{outdir}}/slides.pdf

# `slidecontent.md` is written for this medium on purpose — talking points and
# figures, not document prose reflowed to fit a frame. Overflow is still a
# writing finding, not a build problem to work around: it means a `##` unit in
# the slide file itself is carrying more than one idea, and the `visual`
# reviewer is briefed to report it. Fix the talking points, not the font size.
#
# Nothing here checks for you: pandoc hides the TeX log unless the build fails.
# Look at the deck, or ask the agent to.

# --- Website ----------------------------------------------------------------

# The page links to both PDFs, so this depends on them; without that, a local
# preview has two dead links that only show up after deploying.

# _site/ — one page, sidebar table of contents, both PDFs linked.
site: doc slides
    mkdir -p {{site}}
    {{pandoc}} sections/*.prose.md {{common}} \
        --standalone --toc --toc-depth=2 \
        --template=site/template.html \
        --css=style.css \
        -o {{site}}/index.html
    cp site/style.css {{site}}/
    cp {{outdir}}/document.pdf {{outdir}}/slides.pdf {{site}}/
    mkdir -p {{site}}/figures
    cp -R figures/. {{site}}/figures/
    rm -f {{site}}/figures/README.md

# Serve the site locally at http://localhost:8000.
serve: site
    python3 -m http.server 8000 --directory {{site}}

# --- Viewing ----------------------------------------------------------------

# Open the document PDF.
view-doc: doc
    {{open}} {{outdir}}/document.pdf

# Open the presentation PDF.
view-slides: slides
    {{open}} {{outdir}}/slides.pdf

# --- Publishing -------------------------------------------------------------

# Builds in CI from whatever is on `main` — so commit and push first.
# Requires `gh auth login`, and Pages set to "GitHub Actions" in the
# repository settings.

# Publish the site and both PDFs to GitHub Pages, on demand.
deploy:
    gh workflow run pages.yml
    @echo "Deploy started. Watch it with:  gh run watch"

# --- Housekeeping -----------------------------------------------------------

# Remove all build outputs.
clean:
    rm -rf {{outdir}} {{site}}
