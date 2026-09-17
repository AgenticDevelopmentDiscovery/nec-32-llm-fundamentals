# Motivation — spine

> Note form only; never rendered. See `01-context.concepts.md` for what each
> heading is for.

## Purpose

Say WHY understanding the transformer architecture specifically matters for
agentic development — not for ML in general — and bound where that
understanding pays off most.

## Claims

- Hallucination is a direct consequence of the training objective
  (likelihood, not truth) — an architectural/training fact, not a bug to be
  patched away later.
- The context window is a hard token budget fixed by the architecture;
  retrieval and memory exist because of this constraint, not as a design
  preference.
- Weights are frozen at inference — an agent's "memory" within a conversation
  is entirely whatever fits in the context window, not anything the model
  learns from the interaction.
- Sampling (temperature, stochastic decoding) determines how deterministic an
  agent's output is, which matters directly when building a reproducible eval
  harness.
- A reader who understands the mechanism can reason about why context
  engineering, grounding, and prompt design work, instead of treating the
  model as a black box to be prompted by trial and error.

## Decisions

- Grounded each motivation claim in a specific architectural fact (frozen
  weights, fixed context window, sampling) rather than arguing abstractly
  that "understanding internals is good practice" — concrete traceability
  from mechanism to consequence is what makes this section specific to
  agentic development rather than generic ML advice.
- Chose not to introduce the layer-by-layer architecture here, even briefly —
  motivation is stated in terms of surface behaviors the reader has likely
  already experienced (hallucination, context limits, non-determinism),
  saving the mechanism itself for `03-content`.

## Open questions

- Should this section reference specific downstream systems (an eval
  harness, a capstone project) the way the source `.md` did, or stay generic
  enough to stand alone for a reader outside this course's specific context?
- How concrete should "What Goes Wrong Without It" get — a hypothetical
  failure, or a real transcript/example of an agent hallucinating or
  overrunning its context budget?

## Not doing

- Naming specific mitigations (RAG, memory systems, eval harness design) in
  any depth — this section motivates why they exist, not how to build them;
  that belongs to other tutorials.
- Introducing sampling parameters (temperature, top-p/top-k) by name and
  mechanism — flagged here only as "sampling controls determinism," fully
  unpacked, if at all, in the `03-content` demo.
