# Visual & Multi-Register Exposition — Round 3

**Recommendation:** minor polish
The figure set is strong and well-integrated; the remaining issues are one likely overflow, one register-drift gap on a fact the team already spent real effort getting right, and one under-illustrated but high-payoff concept.

## Slide overflow

- `03-content.slidecontent.md` § Feed-Forward, Residuals, Normalization — likely overflow, and it's estimate-unsure. Four bullets (the Feed-Forward and Residual-connection lines are each ~105–120 characters and will wrap to two lines at slide width) plus a 92%-width horizontal anchor figure leave little vertical room. This is the densest bullet slide in the deck (three concepts — feed-forward, residual, normalization — plus a fourth synthesis bullet), stacked against the widest figure width used anywhere in the `-hl-` series. Worth a direct look at the rendered page; if it's tight, this reads as *too many ideas*, not padding — the fourth bullet ("Without both...") restates urgency the first two bullets already carry.
- `03-content.slidecontent.md` § Demo: A Forward Pass, Layer by Layer — lower-confidence near miss. Three setup bullets, a five-line verbatim block, and a closing bullet, with no figure to compare it against for scale. Probably fits (metropolis verbatim blocks are compact), but it's the only slide combining a multi-line code block with four bullet lines of prose — worth a glance.

## Strengths

- The figure set is uniformly relational, not decorative — no figure here could be deleted without losing a specific structure. `self-attention.svg` shows the actual query/key/value weighting with a real weight distribution, not just labeled boxes; `residuals.svg` exists specifically because a skip connection is an arrow, and the prose had been asking the reader to picture one that wasn't drawn; `demo-attention-map.png` is captured data, not illustration, and it visibly agrees with the worked example in `self-attention.svg` ("it" lights up on "cat" in both).
- The `decoder-only-hl-*.svg` "where we are" device — the anchor diagram repeated with the current region circled on every stack-walkthrough slide — is the right call for the slide register specifically: a slide has no memory of the one before it, and a presenter working from the deck alone needs the re-orientation the document (which has continuous prose and "Figure 2" back-references) does not.
- `04-conclusion`'s "What You Can Do Now," in both `prose.md` and `slidecontent.md`, matches `topic.md`'s "What the reader will be able to do" almost verbatim. The promise-vs-delivery link the spine flags as panel-checked holds.
- `prose.md` headings across all four sections are short, specific, and scannable ("Tokens and Embeddings," "Self-Attention," "Where the Field Is Headed") — a reader landing mid-document from the website would know where they are.
- Figure numbering in `03-content.prose.md` is internally consistent end to end (Figure 1 encoder-decoder → Figure 5 demo-attention), with every in-text reference ("Figure 2," "pictured whole in Figure 4," "Figure 5 captures...") pointing at the right image.

## Weaknesses

- `03-content.slidecontent.md` § Feed-Forward, Residuals, Normalization — the "only one norm per block, and it's after self-attention, not after feed-forward" fact is a claim `prose.md` states explicitly and the figure encodes structurally (one "Norm" box, one bare "+"), but the slide's bullet text never says it. A presenter working from the deck alone, with no memory of the prose, would have to correctly read the absence of a second labeled box to know this — for a fact the `concepts.md` log shows took multiple correction passes to get right in the diagrams themselves. This is exactly the kind of drift the split-source model puts on this seat to watch for: the claim survives in two of three places (prose, figure) but not in the slide's own words.
- `03-content.slidecontent.md` § Tokens → Embeddings carries two figures that teach two different things — `embedding-analogy.svg` (semantic relationships as vector arithmetic) and the anchor diagram (pipeline position) — under one heading with only two bullets. It's the only slide in the run pairing two unrelated figures, which makes it read as two ideas sharing a slide rather than one idea with support.
- `02-motivation` — the context window (a hard token budget; content "doesn't fade gracefully, it's simply gone") has no figure in either register, despite `topic.md` naming it as one of the two or three highest-leverage WHY claims in the whole tutorial. Every other WHY-level claim that got a figure (the agentic loop) is visual in at least one register; this one is prose-only in both.
- `agentic-loop.svg` exists only in `slidecontent.md`, not `prose.md` — logged and deliberate per `concepts.md`, and the one added sentence in `prose.md` carries the claim in words, so this isn't a gap so much as a register choice worth restating here since the brief asks for it: reasonable as-is, register-specific, no action needed.

## Actionable

1. `03-content.slidecontent.md` § Feed-Forward, Residuals, Normalization — cut the fourth bullet ("Without both: a stack more than a handful of layers deep stops being buildable at all") or fold its claim into the Residual-connection bullet, and check the rendered page.
   (*why:* repairs the slide register's one-idea-and-it-fits budget; the cut bullet is a restatement, not new information, so nothing is lost)
2. `03-content.slidecontent.md` § Feed-Forward, Residuals, Normalization — add one clause to the Normalization bullet stating explicitly that only self-attention's residual gets a norm ("Normalization: keeps the numbers stable — but only after self-attention, not after feed-forward").
   (*why:* closes a register gap on a fact that currently exists in `prose.md` and the figure but not in the slide's own text, for a presenter with no access to either)
3. `02-motivation.prose.md` and `02-motivation.slidecontent.md` — add a figure for the context window: a row of fixed token slots, new tokens entering one side, the oldest token dropping off the other with a "gone, not faded" label, and a small arrow labeled "retrieval / memory" feeding content back in from outside the window.
   (*why:* the highest-payoff unillustrated idea in the document — makes the "hard budget, not a fade" claim, which is currently asserted in prose only, visible as a mechanism)
4. `03-content.slidecontent.md` § Tokens → Embeddings — split the semantic-relationship point (embedding-analogy figure) onto its own beat, or drop the anchor "where we are" figure here since Positional Information (the very next slide) repeats the same pipeline position one step later anyway.
   (*why:* restores one-idea-per-slide; the slide currently asks the viewer to hold a geometric-relationship figure and a pipeline-position figure at once)
