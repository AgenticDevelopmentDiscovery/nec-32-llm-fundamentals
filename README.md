# nel-course

A template for **evolving a document by critique**: one artifact, two authored
Markdown registers per section, three outputs, improved one round at a time by
a panel of independent reviewers whose findings are reconciled into a single
ranked docket.

Clone it, replace the content in `sections/`, and run `/round`.

> **[CLAUDE.md](CLAUDE.md) is the method.** How a round works, why the reviewers
> are independent, what the three registers of a section are for, and the
> guardrails — all of it lives there, in one file. This README only covers
> getting the toolchain running and starting a project.

---

## What you get

```
sections/           the source — one triple of files per section
personas/           the reviewer panel, plus the aggregator
rounds/             committed critique history: one folder per round
site/               the website's template and stylesheet
figures/            figures, referenced from the prose and slidecontent
topic.md            the proposal — what this tutorial is and promises
metadata.yaml       title, authors, and the declared audience
justfile            every build recipe
```

| | Command | Output | Source |
| --- | --- | --- | --- |
| Document | `just doc` | `output/document.pdf` | `*.prose.md` |
| Presentation | `just slides` | `output/slides.pdf` | `*.slidecontent.md` |
| Website | `just site` | `_site/index.html` | `*.prose.md` |

`just build` makes all three. `just serve` previews the site locally. The
presentation is **not** generated from the document's prose — it has its own
source, written for the slide medium. See CLAUDE.md's "Why slides get their
own source" if that's surprising.

## Setup

Install the toolchain. On macOS:

```
brew install pandoc just librsvg
brew install --cask mactex-no-gui
```

On Debian or Ubuntu:

```
sudo apt-get install -y pandoc just texlive-xetex texlive-latex-extra \
                        texlive-fonts-recommended librsvg2-bin
```

Then confirm it works before changing anything:

```
just build
```

The placeholder content renders, so a failure here is a toolchain problem, not
your writing.

## Start your project

1. **Say what you are doing.** Fill in [topic.md](topic.md) — the proposal: what
   the topic is, why it belongs in this course, what the reader will be able to
   do afterwards, and what is out of scope. Every reviewer reads it, and the
   panel judges the tutorial against it.
2. **Declare your reader.** Edit [metadata.yaml](metadata.yaml) — the title, the
   authors, and especially `audience`. The pedagogy reviewer judges the document
   against whatever you write there, so a vague audience buys you a vague review.
3. **Write.** Replace the placeholders in `sections/`. Each section is a
   triple: `<name>.prose.md` is the document (and website),
   `<name>.slidecontent.md` is the presentation, `<name>.concepts.md` holds
   the spine behind both. Section order is the numeric filename prefix — add
   a section by adding a numbered triple.
4. **Check it renders.** `just build`.
5. **Run a round.** `/round` in Claude Code. It produces a ranked docket at
   `rounds/round-NNN/SYNTHESIS.md` and stops; you decide what to act on.

## Publishing

The site deploys to GitHub Pages on demand — never automatically on push.

One-time, in the repository settings: **Settings -> Pages -> Source: GitHub
Actions**. Then:

```
git push
just deploy
```

CI installs the toolchain and runs `just build`, so it publishes exactly what
`just serve` showed you. Nothing generated is stored in git.

## Derived from

The `nel-operator` engine, reduced to its teaching core. The section-pair
convention, the reviewer-panel critic, and the never-reverted single manuscript
come from there; the compile and metrics gates, the archive, the scaffolder, and
the unattended loop deliberately do not.
