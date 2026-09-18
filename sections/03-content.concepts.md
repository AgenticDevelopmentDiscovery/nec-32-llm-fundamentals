# Content — spine

> Note form only; never rendered. See `01-context.concepts.md` for what each
> heading is for.

## Purpose

Teach the HOW: the original encoder-decoder transformer, why most current
LLMs moved to decoder-only, and a layer-by-layer walkthrough of the
decoder-only stack — so the reader can trace what happens to the data at
every stage, ending in a hands-on demo that shows it on a real model.

## Claims

- The original Transformer (Vaswani et al., "Attention Is All You Need") is
  an encoder-decoder architecture, built for sequence-to-sequence tasks like
  translation.
- Most current LLMs (GPT-family and similar) use a decoder-only variant: one
  stack, no separate encoder, trained purely as a next-token predictor over
  its own input.
- A decoder-only layer's data flow is: token embedding plus positional
  information, then self-attention (mixing information across positions),
  then a feed-forward block (per-token transformation), held trainable at
  depth by residual connections and normalization — repeated for N layers,
  ending in a projection to a probability distribution over the vocabulary.
- Self-attention is what lets a token's representation depend on every other
  token in the context, at every layer — this is the mechanism the "context
  window" claims in `02-motivation` are actually about.
- Stacking many identical layers, not one complex layer, is how the model
  builds increasingly abstract representations of the sequence.
- A layer runs several attention mechanisms in parallel ("heads"), each free
  to focus on a different relationship, then combines their results — one
  sentence, not a mechanism the walkthrough unpacks further.

## Decisions

- Opens with the original encoder-decoder architecture, rather than starting
  straight at decoder-only, per the primary author's explicit brief — gives
  the reader a historical anchor before seeing what was removed to reach
  today's models.
- Chose a layer-by-layer walkthrough (embeddings, attention, feed-forward,
  residuals/norm, stack, output) over a component-by-component tour (e.g.
  "everything about attention, then everything about feed-forward"), because
  the author asked specifically for what happens to the data "in every
  layer" — a pass through the data, not a catalog of mechanisms.
- Combined feed-forward + residuals + normalization into one document
  subsection, and "stacking layers" + "output distribution" into another —
  this grouping is about the *argument*, not slide fit, now that slides have
  their own source (below).
- Placed the hands-on demo at the end of this section, not in a separate
  section, because it depends on the walkthrough already having happened.
  Chosen over the source `.md`'s original tokenizer/temperature-sampling
  demo, which is about I/O rather than mechanism — see `topic.md`'s Demo
  section.
- Demo built and run (2026-09-17): tensor-shape / attention-map inspection
  on GPT-2 small, layer by layer, on the example sentence already used in
  Self-Attention — both `prose.md` and `slidecontent.md` now show real
  captured output, not a description of the plan.
- Figures are hand-drawn originals, adapted from and attributed to
  "Attention Is All You Need" and the GPT paper line, not reused as
  published (2026-09-17, supersedes the "reuse as-is" call in `topic.md`'s
  original Scope) — redistribution rights on the published figures couldn't
  be confirmed. All three figures now carry consistent attribution
  ("Adapted from..." / "Illustrates the mechanism described in...").
- **`prose.md` and `slidecontent.md` split onto separate sources (2026-09-17)
  — see `topic.md` Decisions for why.** `prose.md` went back from 11 `##`
  units to 8, matching the document's natural subsections, with all three
  original figures embedded inline in the argument rather than on their own
  heading-slide. `slidecontent.md` is new: 14 `##` units (13, then +1 for the
  new residuals figure below), each one idea and (where relevant) one figure,
  written as talking points rather than reflowed prose. The figure/text split
  that used to live inside `prose.md` (e.g. "The Encoder-Decoder Stack,
  Visualized" as its own heading) now lives entirely in `slidecontent.md`,
  where it belongs.
- **Added a fourth figure, `figures/residuals.svg`, for Feed-Forward/
  Residuals/Normalization (2026-09-17).** This was the one core mechanism in
  the walkthrough with no supporting image — a skip connection is
  definitionally a relationship (an arrow bypassing a box), and the prose was
  asking the reader to picture a structure it didn't draw. Shows one full
  decoder block: self-attention and feed-forward, each followed by a residual
  add and a norm. In `prose.md` it's Figure 4, which pushed the demo's
  attention-map figure to Figure 5 — the in-text reference in the Demo
  section was updated to match.
- **Added the missing back-references to the anchor figure.** Feed-Forward
  now points to Figure 2 (where it sits in the overall stack) and to the new
  Figure 4 (its own detailed diagram); Stacking Layers now points to Figure 4
  ("pictured whole in Figure 4 — repeated N times"). Self-Attention and
  Tokens/Embeddings already had theirs. Every unit between the anchor figure
  and the demo now orients the reader back to a picture, in both registers.
- **Self-Attention, Visualized caption restored to self-contained
  (2026-09-17).** The caption had been shortened to fix slide overflow,
  which dropped the example sentence and left the caption assuming the
  reader had just seen the prior slide — the exact defect this caption was
  supposed to fix. Restored the sentence and shrank the image further
  (width 55%) instead, so it fits without cutting the one thing that makes
  it stand alone.
- Self-Attention gets one added sentence naming multi-head attention
  (confirmed 2026-09-17) — enough that the term isn't a surprise elsewhere,
  without unpacking why multiple heads or how they're combined. Present in
  both `prose.md` and `slidecontent.md`.
- Named "cross-attention" explicitly in the Encoder-Decoder unit (2026-09-17,
  both registers) instead of introducing the term cold in a later figure
  caption — the mechanism was already described there, just not named.
- **`slidecontent.md` now repeats the anchor diagram, circled, on every
  unit that walks through one piece of the stack (2026-09-17), per the
  primary author** — see `topic.md` Decisions. New compact horizontal
  figures (`figures/decoder-only-hl-*.svg`) on Tokens/Embeddings,
  Positional Information, Self-Attention, Feed-Forward/Residuals
  /Normalization, and Stacking. `prose.md` was not changed for this — the
  document already orients the reader with in-text figure references
  ("Figure 2," "pictured whole in Figure 4"), which don't need a repeated
  image the way a slide, read in sequence with nothing to look back at,
  does.
- **Removed the H1 from `slidecontent.md` (2026-09-17), per the primary
  author** — see `topic.md` Decisions for the section-divider-slide
  removal this was for.
- Cut "gradients" and "stops training reliably" from Feed-Forward/Residuals
  /Normalization in both registers (2026-09-17) — training vocabulary the
  tutorial explicitly scopes out. Replaced with "keeps a straight path
  through the whole stack" / "stops being buildable at all," which makes the
  same claim without assuming the reader knows what a gradient is.

- **Slide-by-slide pass with the primary author (2026-09-18) — `slidecontent.md`
  only, `prose.md` untouched.** `slidecontent.md` went from 14 `##` units to
  11. Changes, in order:
  - Merged "The Encoder-Decoder Stack, Visualized" into "The Original
    Transformer: Encoder-Decoder" (text + figure, one slide) and cut the
    bullet naming cross-attention — the figure's own caption already names
    it, so nothing was lost.
  - Merged "The Decoder-Only Stack — the Anchor Diagram" into "From
    Encoder-Decoder to Decoder-Only" the same way, cutting two trailing
    bullets ("trains on any text..." / "why decoder-only scaled") as
    redundant with what's already said. The anchor figure had to shrink to
    20% width to fit alongside three bullets, and its own caption had to be
    cut drastically (one line, not the original multi-clause one) — a long
    caption wraps to *more* lines at a narrow image width, which cost more
    vertical space than the image itself, not less.
  - Added `figures/embedding-analogy.svg` (the classic king − man + woman ≈
    queen parallelogram) to Tokens → Embeddings, illustrating "comes to
    encode meaning as training proceeds" concretely.
  - Removed "The Decoder Block, Visualized" (`figures/residuals.svg` on its
    own slide) — judged as redundant once the anchor strip's residual arcs
    (below) made the same point in-line on the Self-Attention and
    Feed-Forward slides. `residuals.svg` stays as Figure 4 in `prose.md`,
    unaffected.
  - Removed "Stacking to a Next-Token Distribution" — per the primary
    author, the slide was mostly filler around one real bullet. Replaced
    with a new slide, "From the Stack to Next-Token Probabilities," built
    specifically around what the old slide gestured at but didn't earn:
    the final norm, the Linear+Softmax projection, and the resulting
    distribution.
  - **`figures/decoder-only.svg` and all `figures/decoder-only-hl-*.svg`
    redesigned (2026-09-18), per the primary author:** the input stage now
    shows Words → Tokens → Token+Positional Embedding as three boxes
    instead of one, and green residual (skip) arrows with "+" merge nodes
    are drawn explicitly around Self-Attention and Feed-Forward in every
    variant, not just in the now-removed `residuals.svg` detail slide. The
    vertical anchor diagram dropped its ghosted "Encoder/Cross-Attention
    (removed)" annotations to make room — that context is already
    established on the prior slide. `decoder-only-hl-stacking.svg` (no
    longer referenced after the Stacking slide was cut) was deleted;
    `decoder-only-hl-output.svg` was added, highlighting Linear+Softmax and
    the next-token output for the new final-stages slide.
  - Removed the separate "Final Layer Norm" box from every figure, on the
    theory that it was just the last Add & Norm from the ×N repeat —
    **superseded same day, see below.**
  - Wordsmithed "Tokens → Embeddings" bullets and other minor phrasing
    across several slides in response to direct feedback; no other
    structural changes.

- **Correction (2026-09-18, later the same day), per the primary author
  after checking the GPT paper: the entry above was backwards.** There IS a
  final layer norm outside the ×N loop — that part was right to remove
  Norm from, just not the box the removal targeted. What's actually true:
  each repeated block has exactly **one** norm, immediately after the
  self-attention residual; the feed-forward residual adds and the block
  exits with no norm of its own. The separate Final Layer Norm, after the
  last block and before Linear+Softmax, is real and outside the loop.
  - `figures/decoder-only.svg`: restored the "Final Layer Norm" box between
    the ×N bracket and Linear+Softmax; removed the label from the *second*
    "Add & Norm" inside the loop, which is now just "Add" — its "+" node
    connects straight up past the bracket boundary to Final Layer Norm. The
    first "Add & Norm" (after self-attention) is untouched.
  - All four `figures/decoder-only-hl-*.svg` variants: same fix — box 6
    relabeled "Add" (was "Add & Norm"), a "Final Norm" box reinstated
    before Linear+Softmax, viewBox widened back to 890 to fit the restored
    box. `decoder-only-hl-output.svg`'s highlight ellipse now spans Final
    Norm + Linear+Softmax + Next-token (three boxes, not two).
  - `figures/residuals.svg`: removed its second "Norm" box the same way —
    Feed-Forward's residual "+" now connects straight to the block's
    output. Caption updated to say only self-attention's residual is
    followed by a norm.
  - `prose.md` updated to match, in both places that made the old (wrong)
    claim: the Feed-Forward/Residuals/Normalization paragraph now says
    explicitly "only one norm per layer... the feed-forward residual adds
    and moves straight on"; the Stacking Layers paragraph now names the
    **final layer norm** as a real, distinct step after the last block and
    before the Linear+Softmax projection. Figure 4's (`residuals.svg`)
    caption in `prose.md` corrected the same way.
  - `slidecontent.md`'s "From the Stack to Next-Token Probabilities" slide
    got its Final Norm bullet back, worded to make clear it's outside the
    loop ("the only norm that isn't repeated per layer").

## Open questions

- (none outstanding as of 2026-09-18)

## Not doing

- The attention math (softmax(QKᵀ/√d)V) as a derivation — the walkthrough
  says what self-attention does to the data, not how the formula is derived.
  Out of scope per `topic.md`.
- Backpropagation, or how the weights in each layer were learned — out of
  scope per `topic.md`; this section is a forward-pass tour only.
- Tokenizer internals (BPE) beyond "text becomes token ids" — the Tokens and
  Embeddings unit takes tokens as a given input, not something to construct.
