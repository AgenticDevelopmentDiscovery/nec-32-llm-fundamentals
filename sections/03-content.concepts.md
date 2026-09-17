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

## Open questions

- Does the proposed demo (tensor-shape / attention-map inspection on a small
  real model, layer by layer) match what the primary author has in mind?
  This blocks writing the demo's actual content and code — flagged in
  `topic.md` as needing author confirmation.
- Which figures specifically, and do any need redrawing or simplifying to
  survive `--slide-level=2`? The original "Attention Is All You Need" figure
  is dense; CLAUDE.md treats slide overflow as a finding about the content,
  not something to shrink-to-fit.
- Is 8 `##` units the right first-pass granularity, or should the combined
  units (feed-forward+residuals+norm; stacking+output) be split now instead
  of waiting for round feedback?
- How much does the reader need to know about multi-head attention
  specifically, versus single-head self-attention as a mental model — an
  unresolved level-of-detail question for the Self-Attention unit.

## Not doing

- The attention math (softmax(QKᵀ/√d)V) as a derivation — the walkthrough
  says what self-attention does to the data, not how the formula is derived.
  Out of scope per `topic.md`.
- Backpropagation, or how the weights in each layer were learned — out of
  scope per `topic.md`; this section is a forward-pass tour only.
- Tokenizer internals (BPE) beyond "text becomes token ids" — the Tokens and
  Embeddings unit takes tokens as a given input, not something to construct.
