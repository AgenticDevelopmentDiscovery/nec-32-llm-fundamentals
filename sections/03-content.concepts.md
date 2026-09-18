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

- **Figure cleanup pass (2026-09-18), per the primary author: three
  distinct bugs found and fixed across the `decoder-only-hl-*.svg`
  horizontal strips and two merged slides.**
  - **Backward arrows.** Each of the four `decoder-only-hl-*.svg` files had
    two short connector stubs (from the residual "+" node toward the next
    box) with their start/end coordinates swapped, so the arrowhead pointed
    back into the "+" circle instead of forward. Root cause: the "+" circle
    and the box after it already touch with no real gap, so the connector
    was geometrically redundant — removed both stubs in all four files
    rather than redrawing them, since there was never room for a real
    arrow there.
  - **The ×N bracket didn't surround anything.** The horizontal strips used
    a thin dashed pill drawn *underneath* the repeated boxes, not a
    rectangle enclosing them — inconsistent with `encoder-decoder.svg` and
    `decoder-only.svg`, both of which correctly draw a full dashed
    rectangle around the repeated region with the ×N circle at its
    top-left corner. Redrew the bracket in all four `decoder-only-hl-*.svg`
    files to match that pattern: one rectangle enclosing Self-Attn through
    Add (including the residual arcs above them), not a strip below them.
  - **Two slides ran off the bottom.** `03-content.slidecontent.md`'s
    merged "The Original Transformer: Encoder-Decoder" (`encoder-decoder.svg`
    at 62% width) and "From Encoder-Decoder to Decoder-Only"
    (`decoder-only.svg` at 20% width) both overflowed. `decoder-only.svg`
    grew substantially taller earlier the same day (words/tokens/position
    rows, residual arrows, the restored Final Layer Norm), so its old 20%
    width no longer fit at the new aspect ratio — dropped to 13%.
    `encoder-decoder.svg` didn't change, but apparently was never re-checked
    at 62% after the three-bullet text was finalized on that slide —
    dropped to 34%. Both re-verified by rendering, not estimating.
  - Audited every other hand-drawn figure (`self-attention.svg`,
    `agentic-loop.svg`, `embedding-analogy.svg`, `residuals.svg`,
    `decoder-only.svg`, `encoder-decoder.svg`) arrow-by-arrow for the same
    backward-arrow pattern — none found elsewhere.

- **Missing Embeddings step restored, and the two still-cramped slides
  resized (2026-09-18, later the same day), per the primary author: the
  pipeline diagrams had silently skipped a step.**
  - **The bug.** Every decoder-stack figure (`decoder-only.svg` and all
    four `decoder-only-hl-*.svg` strips) went straight from a "Tokens" box
    to a combined "Token + Position" box — collapsing the embedding lookup
    into the positional step instead of showing it as its own stage. Fixed
    everywhere to the correct four-step input pipeline: **Words → Tokens →
    Embeddings → Embeddings + Position.** `decoder-only.svg`'s viewBox grew
    (780 → 838) to fit the new box; the four horizontal strips grew wider
    (890 → 970 viewBox) and moved to an 11-box layout. Re-rendered and
    visually re-verified all five files, not just the one that changed
    first.
  - **The two previously-shrunk slides were now too small to read.**
    Shrinking `encoder-decoder.svg` and `decoder-only.svg` to 34%/13% width
    (the prior fix, above) bought back the overflow but made both figures
    hard to read once actually rendered. Removed the pandoc caption text on
    both (the attribution/description lines that are baked into the SVGs
    themselves stay — only the redundant markdown caption was cut) and
    grew `encoder-decoder.svg` back to 48%, which fits with room to spare.
    `decoder-only.svg` — tall and narrow, and taller still after the
    Embeddings fix — didn't fit at any single-column width without either
    overflowing vertically or shrinking unreadably; moved "From
    Encoder-Decoder to Decoder-Only" to a two-column layout (bullets left,
    figure right at 85% of its column), which lets the figure use the
    slide's full height instead of being width-constrained. Re-rendered
    every slide the horizontal strips appear on (Tokens → Embeddings,
    Positional Information, Self-Attention, Feed-Forward/Residuals
    /Normalization, From the Stack to Next-Token Probabilities) to confirm
    the wider viewBox introduced no new overflow — none did.
  - `residuals.svg` (the single zoomed-in "Input from previous layer" detail
    figure used once in `prose.md`) was left alone — it never showed the
    input pipeline, so the missing-step bug didn't apply to it.
    `prose.md`'s "Tokens and Embeddings" section already described the
    lookup and the positional add as two separate sentences, so needed no
    text change — the bug was in the diagrams, not the prose.

- **Two follow-up bugs from the caption-removal pass, caught by the primary
  author on the next look (2026-09-18, same day): a left-aligned figure and
  a slight vertical overflow.**
  - **`encoder-decoder.svg` wasn't centered.** Pandoc's `implicit_figures`
    extension only wraps a standalone image in `\begin{figure}\centering
    ...\end{figure}` when it has caption text; an image with empty alt text
    (`![]`) gets emitted as a bare `\includesvg`, which beamer left-aligns.
    Removing the caption on "The Original Transformer: Encoder-Decoder" (the
    prior fix) silently cost it its centering. Fixed by wrapping the image
    in explicit ` ```{=latex}\begin{center}...\end{center}``` ` raw blocks —
    plain `\begin{center}` text in the markdown doesn't work, since raw
    LaTeX isn't passed through by pandoc's default markdown reader without
    the `{=latex}` fenced-block form (the `raw_attribute` extension, on by
    default).
  - **`decoder-only.svg` in the two-column layout was clipping its own
    bottom caption line by a few points.** The image is bound by both
    `width` and `height=\textheight` (pandoc's svg default), and it was
    genuinely height-bound, not width-bound — so shrinking the `width`
    attribute alone (85% → 78% → 68%) had no effect on the actual
    overflow, since height was already the tighter constraint at every one
    of those widths. Fixed by adding an explicit `height=85%` attribute
    alongside `width=78%`, capping the LaTeX height bound below
    `\textheight` directly instead of trying to reach it indirectly through
    width. Re-rendered at 200 DPI and visually confirmed all three caption
    lines now sit fully inside the frame.

- **The four `decoder-only-hl-*.svg` horizontal strips had a duplicated
  residual add and a missing arrow, both introduced by the 11-box rewrite
  earlier the same day (2026-09-18), caught by the primary author.**
  - **Duplicated add.** The rewrite kept the pre-Embeddings labels "Add &
    Norm" and "Add" on the two post-block boxes, even though each one now
    sits right after a green "+" circle that already draws the residual
    add — so the box's own label was re-asserting an operation the diagram
    had already shown happening. The vertical `decoder-only.svg` never had
    this problem; it already labeled the first box "Norm" alone and had no
    box at all after the second "+". Brought the horizontal strips in line
    with it: renamed "Add & Norm" → "Norm" (the "+" is the add; the box is
    only the norm), and deleted the second "Add" box outright — after the
    feed-forward residual there is nothing left to draw, since no norm
    follows it.
  - **Missing arrow, and a new one needed.** Two flow arrows were absent:
    between the Norm box and Feed-Forward (present as a gap in the source
    with no `<line>` filling it — an oversight in the original 11-box
    build, not something the box count changed) and, after deleting the
    "Add" box, between the second "+" circle and Final Norm (previously
    unnecessary because the "Add" box touched the circle directly; Final
    Norm doesn't touch it at that spacing, so it needs a real arrow, not a
    touching edge). Added both.
  - **Box count dropped from 11 back to 10** with the "Add" box gone,
    which incidentally returned the strips to the same `890`-ish viewBox
    width used before the Embeddings box existed (now `910`, to keep a
    clean gap between the second "+" circle and Final Norm so the ×N
    bracket has room to close without visually cutting into either). All
    four highlight ellipses were recomputed for the shifted box positions
    and re-verified by rendering, not by re-deriving coordinates on paper
    only — every one of the five affected slides (Tokens → Embeddings,
    Positional Information, Self-Attention, Feed-Forward/Residuals
    /Normalization, From the Stack to Next-Token Probabilities) was
    re-rendered at 150 DPI to confirm no new overflow from the width
    change.

- **Two small, unrelated visual bugs fixed same day (2026-09-18), caught by
  the primary author on a later look.**
  - **`embedding-analogy.svg` axis labels weren't centered.** `.axis-lbl`
    had no `text-anchor`, so both labels (default left-anchor) drifted off
    their axis midpoints — "royal" direction sat visibly right of center
    under the bottom arrow, and "gender" direction (rotated -90°) sat
    outside the plot frame entirely, past the "queen" label. Added
    `text-anchor: middle` to the class and re-centered the gender label's
    rotation pivot on the true vertical midpoint of its arrows (y=119, was
    125). Re-rendered and confirmed both labels sit on their axes.
  - **`demo-attention-map.png` showed a "Ġ" before every token label except
    "The."** This isn't a bug in the figure — it's GPT-2's byte-level BPE
    tokenizer marking "this token follows a space" with a literal "Ġ"
    (U+0120) character, which shows on every token here except the
    sentence-initial "The." `demo/forward_pass.py` was plotting the raw
    tokenizer output directly. Fixed by stripping "Ġ" from the axis labels
    only (`display_tokens`), leaving the raw `tokens` list untouched
    everywhere else (console output, the next-token lookup) since that
    tokenizer detail is real and worth showing in the text, just not
    legible as an axis label. Reran the actual model (not hand-edited the
    PNG) to regenerate `figures/demo-attention-map.png` — same input, same
    weights, same layer/head, so the data is unchanged; only the labels
    are clean now.

- **Round 3 docket, closed out (2026-09-18): all seven items acted on**,
  plus one figure fix outside the docket, per the primary author.
  - Feed-Forward/Residuals/Normalization slide: cut the fourth bullet into
    the residual bullet; added, then (per the primary author, next look)
    trimmed back out, a clause on the Normalization bullet stating
    self-attention-only norming — left as a talking point, not slide text.
  - Added the `topic.md`-promised temperature callback to the demo, both
    registers.
  - Corrected `02-motivation.concepts.md`'s wordsmith-decision entry to
    state it was `slidecontent.md`-only and later superseded, rather than
    rewriting `prose.md`'s independent "folklore" sentence, which was
    never in scope of that edit.
  - Reconciled "softmax" into `prose.md` (linear layer + softmax), matching
    the term already on the slide and already labeled in the figures.
  - Fixed the dangling "this mechanism" pronoun in `02-motivation.prose.md`
    by naming the referent directly.
  - Added a transition into the layer-by-layer walkthrough at the top of
    "Tokens and Embeddings" — expanded per the primary author beyond a bare
    signpost into an explicit words→tokens step ("the collection of words
    is first turned into tokens..."), closing a real gap: the prose had
    jumped straight to "every token id is looked up" without ever saying
    how raw text becomes tokens in the first place, unlike the figures,
    which already showed a distinct Tokens box.
  - Reworded "agentic tool use" in `04-conclusion` (both registers) to
    "autonomous, multi-step tool use," since `02-motivation` already
    establishes agentic-systems-as-action-taking-LLM as the tutorial's
    settled premise, not a field frontier.
  - **Residual arc redesign in all four `decoder-only-hl-*.svg` strips
    (not a docket item — raised directly by the primary author after
    looking at the deck).** Two passes. First: the arcs started at a point
    on the source box's *left edge*, mid-height, so the curve visibly cut
    across the box's own top-left corner before escaping upward — moved
    the start to the box's top edge instead. The primary author caught
    that this was still wrong on the next look: architecturally, a
    residual carries forward the block's *input*, so the branch point
    belongs on the incoming flow arrow, before the block, not on the block
    itself. Final fix: each arc now branches from a small marked dot on
    the arrow feeding into its block (before Self-Attn, before
    Feed-Forward), rises with a vertical tangent, arcs over the block, and
    descends with a vertical tangent into the "+" node — a symmetric,
    clean bridge shape, verified at both zoomed-in and actual deck
    resolution.

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
