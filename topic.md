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
  tutorial by design. Figures are hand-drawn originals, adapted from and
  attributed to the primary sources rather than reused as published: the
  encoder-decoder and decoder-only architecture figures from "Attention Is
  All You Need," and supporting figures from the GPT paper line (e.g.
  "Language Models are Few-Shot Learners") where they illustrate a point the
  source paper doesn't — each figure carries a citation back to its source
  paper. See Decisions for why.
- A short hands-on demo — built and captured; see Decisions.

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
  Is All You Need" (figure attributed), motivates the shift to decoder-only,
  then walks the decoder-only stack layer by layer using the decoder-only
  architecture figure as the anchor visual, each figure carrying its source
  citation. Closes with the hands-on demo (below), which needs the layer
  walkthrough already done to land. `prose.md` and `slidecontent.md` are
  separate documents as of 2026-09-17 (see Decisions) — `prose.md` needs
  enough `##` subsections to carry the document's argument; `slidecontent.md`
  needs enough `##` units, independently, to keep one idea and its figure per
  slide. The two counts will not match, and shouldn't be forced to.
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

- **Split the presentation onto its own source, `slidecontent.md`, separate
  from `prose.md` (2026-09-17).** Two rounds of review kept finding the same
  tension under the old shared-source model: prose dense enough to earn its
  place in the document was consistently too wordy once it hit a projected
  slide (`03-content`'s figure- and demo-bearing units needed splitting
  across 11 slides to avoid overflow, for content that reads as 8 natural
  subsections in the document). Chosen over continuing to force one register
  to serve both mediums. Cost: prose and slidecontent can now drift from each
  other, which the `clarity` and `pedagogy` panel briefs are updated to watch
  for explicitly.
- Figures from "Attention Is All You Need" and the GPT paper line are
  hand-drawn originals, adapted from and attributed to those papers, not the
  papers' actual figures reused as-is (2026-09-17) — the redistribution
  rights on the original published figures couldn't be confirmed. If a
  figure proves too dense for a slide, the fix is still splitting the `##`
  unit around it, not shrinking or redrawing.

- Tokenization, sampling controls, and failure-mode material from the source
  `.md` stay as brief mentions inside `02-motivation` (in service of the
  hallucination/determinism argument) — no dedicated `##` unit. Chosen over
  giving it its own slide or cutting it to a pointer-only mention.
- The `03-content` demo is a layer-by-layer forward-pass inspection: load a
  small open-weights decoder-only model, print the tensor shape (and, where
  feasible, an attention-map snapshot) after each layer. Chosen over the
  source `.md`'s original tokenizer/temperature demo because it exercises the
  architecture the walkthrough just taught, rather than I/O behavior.
- "Where the Field Is Headed" in `04-conclusion` stays at the category level
  (scaling, long-context, MoE, multimodality, agentic tool use) with no named
  models or papers, so the section doesn't go stale as specific models age
  out.

## Open questions

- (none outstanding as of 2026-09-17 — see Decisions above)
