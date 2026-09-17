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
- Cut "gradients" and "stops training reliably" from Feed-Forward/Residuals
  /Normalization in both registers (2026-09-17) — training vocabulary the
  tutorial explicitly scopes out. Replaced with "keeps a straight path
  through the whole stack" / "stops being buildable at all," which makes the
  same claim without assuming the reader knows what a gradient is.

## Open questions

- (none outstanding as of 2026-09-17)

## Not doing

- The attention math (softmax(QKᵀ/√d)V) as a derivation — the walkthrough
  says what self-attention does to the data, not how the formula is derived.
  Out of scope per `topic.md`.
- Backpropagation, or how the weights in each layer were learned — out of
  scope per `topic.md`; this section is a forward-pass tour only.
- Tokenizer internals (BPE) beyond "text becomes token ids" — the Tokens and
  Embeddings unit takes tokens as a given input, not something to construct.
