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
- Combined feed-forward + residuals + normalization into one `##` unit, and
  "stacking layers" + "output distribution" into another, as a first-pass
  slide granularity (8 units total). Expect the `visual` reviewer to flag any
  of these as overloaded once drafted — see CLAUDE.md's slide-overflow
  guardrail — and split further at that point rather than guessing right now.
- Placed the hands-on demo at the end of this section, not in a separate
  section, because it depends on the walkthrough already having happened.
  Chosen over the source `.md`'s original tokenizer/temperature-sampling
  demo, which is about I/O rather than mechanism — see `topic.md`'s Demo
  section.
- Chose to reuse and cite figures from "Attention Is All You Need" and the
  GPT paper line rather than commission new diagrams, per explicit author
  direction — see `topic.md` Scope.
- Demo confirmed with the primary author (2026-09-17) as tensor-shape /
  attention-map inspection on a small real model, layer by layer — see
  `topic.md` Decisions. Not yet built; the prose slide is a description of
  the plan, not the demo itself.
- Figures confirmed reused as-is, not redrawn (2026-09-17). If a figure
  proves too dense for a slide once embedded, the fix is splitting the `##`
  unit around it, not shrinking or redrawing the figure.
- 8 `##` units confirmed as the right granularity (2026-09-17) — the
  rendered slide deck was checked page by page and neither combined unit
  (feed-forward+residuals+norm; stacking+output) overflows.
- Self-Attention gets one added sentence naming multi-head attention
  (confirmed 2026-09-17) — enough that the term isn't a surprise elsewhere,
  without unpacking why multiple heads or how they're combined.

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
