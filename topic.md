# Topic

## In one sentence

The Transformer architecture that turns a sequence of tokens into the
next-token predictions an LLM samples from, and that therefore underlies every
capability and failure mode of an agent built on one.

## What it is

A large language model is a neural network — almost always a Transformer —
trained to predict the next token in a sequence. Text is broken into tokens by
a tokenizer, the model consumes a sequence of token ids and outputs a
probability distribution over the next token, and generation proceeds
autoregressively: sample a token, append it, feed the longer sequence back in,
repeat. There is no database lookup and no symbolic reasoning engine
underneath — just a large, learned function mapping token sequences to
next-token probabilities, evaluated one layer at a time.

## Why it belongs in this course

Every capability and every failure mode an agent exhibits traces back to this
mechanism. Hallucination is the model confidently sampling plausible-but-wrong
tokens because it optimizes likelihood, not truth. The context window is a
hard token budget that motivates the entire context-engineering spine —
retrieval and memory exist to put the right tokens in front of a model whose
weights are frozen at inference. Temperature and sampling control how
deterministic an agent is, which matters when an eval harness needs
reproducible output. A student who has walked through the architecture
layer-by-layer can reason about why these levers work, instead of treating the
model as an opaque box to be prompted by trial and error.

## What the reader will be able to do

- Explain, at a high level, what a transformer is and why LLMs are built on it.
- Trace a token sequence through a decoder-only transformer layer by layer —
  embedding, positional information, self-attention, feed-forward, residuals
  and normalization — and describe what each stage does to the data.
- Explain how the decoder-only architecture used by most current LLMs relates
  to the original encoder-decoder architecture introduced in "Attention Is All
  You Need."
- Connect architectural facts (fixed context window, frozen weights at
  inference, stochastic sampling) to the practical behaviors and failure modes
  an agent built on an LLM will exhibit.

## Scope

**In scope**

- What a transformer is, at a high level (WHAT).
- Why understanding the architecture matters for building and debugging
  agentic systems (WHY) — context window, frozen weights, hallucination,
  sampling/determinism.
- How a transformer processes data (HOW, the meat of the tutorial):
  - The original encoder-decoder architecture from "Attention Is All You Need."
  - Why most current LLMs moved to a decoder-only variant.
  - A layer-by-layer walkthrough of the decoder-only architecture: what
    happens to the data at each stage, and why.
- A thought-provoking, high-level survey of current LLM developments to close
  on (CONCLUDE).
- Figures at every stage the architecture can be drawn — this is a visual
  tutorial by design. Figures are reused and attributed from the primary
  sources rather than redrawn from scratch: the encoder-decoder and
  decoder-only architecture figures from "Attention Is All You Need," and
  supporting figures from the GPT paper line (e.g. "Language Models are
  Few-Shot Learners") where they illustrate a point the source paper doesn't
  — each figure carries a citation back to its source paper.
- A short hands-on demo — see Shape below for the current best candidate.

**Out of scope** — each item below is covered by a different tutorial
elsewhere in the course, so `01-context` names it in passing (one line) as a
pointer rather than silence, without pulling it into this tutorial's scope.

- Derivations of the attention math or training algorithms (backprop,
  optimizer internals) — the tutorial explains what each layer does to the
  data, not how the weights that do it were learned; training mechanics belong
  to whichever tutorial covers model training.
- Tokenizer internals (BPE mechanics) beyond what is needed to say "text
  becomes token ids" — tokenization is context for the walkthrough here, not
  the subject of it; covered in depth elsewhere.
- Fine-tuning, RLHF mechanics, and prompt-engineering technique — covered by
  other tutorials in the course; this one is about the architecture itself.

## Shape

- `01-context` (WHAT): a transformer at a high level — next-token prediction,
  autoregressive generation, the shape of the problem it solves. Closes with a
  one-line "not covered here, see..." pointer for each out-of-scope item
  (training mechanics, tokenizer internals, fine-tuning/RLHF/prompting), so
  the reader knows the omission is deliberate and where to find it, without
  turning `01-context` into a syllabus.
- `02-motivation` (WHY): why this matters for agentic development — ties
  architecture facts to context-engineering, hallucination, and reproducible
  evals, so the reader has a reason to sit through the architecture walkthrough
  that follows.
- `03-content` (HOW): the tutorial's center of mass, per the primary author's
  brief. Opens with the original encoder-decoder architecture from "Attention
  Is All You Need" (figure reused, attributed), motivates the shift to
  decoder-only, then walks the decoder-only stack layer by layer using the
  decoder-only architecture figure as the anchor visual — reused/annotated
  across multiple `##` units as the walkthrough moves through it, each carrying
  its source citation. Closes with the hands-on demo (below), which needs the
  layer walkthrough already done to land. This section will need more than the
  shipped four `##` units once broken up for slides — each stage of the layer
  walkthrough, and the demo itself, are plausibly their own slides.
- `04-conclusion` (WHAT ELSE): what the reader can now do, plus a
  thought-provoking, high-level look at current LLM developments (e.g. scaling,
  long-context, mixture-of-experts, multimodality, agentic tool use) as
  further reading / food for thought rather than material to be tested on.

## Demo

A short hands-on demo is in scope, placed at the end of `03-content` once the
architecture walkthrough has established what a forward pass through the
layers actually does. Confirmed with the primary author (2026-09-17), in
keeping with the architecture-first framing (rather than the source `.md`'s
tokenizer + temperature-sampling demo, which is more about I/O than
mechanism): load a small open-weights decoder-only model and print/visualize
the tensor shape
(and, if feasible, an attention-map snapshot) after each layer for a short
input, so the reader watches the layer-by-layer walkthrough happen on real
data instead of taking it on faith. Sampling temperature can still get a
one-line callback here since it's already covered under Why (Spine 1 /
capstone connection), but it is not the demo's focus.

## Decisions (resolved 2026-09-17)

- Tokenization, sampling controls, and failure-mode material from the source
  `.md` stay as brief mentions inside `02-motivation` (in service of the
  hallucination/determinism argument) — no dedicated `##` unit. Chosen over
  giving it its own slide or cutting it to a pointer-only mention.
- The `03-content` demo is a layer-by-layer forward-pass inspection: load a
  small open-weights decoder-only model, print the tensor shape (and, where
  feasible, an attention-map snapshot) after each layer. Chosen over the
  source `.md`'s original tokenizer/temperature demo because it exercises the
  architecture the walkthrough just taught, rather than I/O behavior.
- Figures from "Attention Is All You Need" and the GPT paper line are reused
  as-is, not redrawn. If a figure proves too dense for a slide, the fix is
  splitting the `##` unit around it, not shrinking or redrawing the figure —
  consistent with CLAUDE.md's "overflow is a writing problem" stance.
- "Where the Field Is Headed" in `04-conclusion` stays at the category level
  (scaling, long-context, MoE, multimodality, agentic tool use) with no named
  models or papers, so the section doesn't go stale as specific models age
  out.

## Open questions

- (none outstanding as of 2026-09-17 — see Decisions above)
