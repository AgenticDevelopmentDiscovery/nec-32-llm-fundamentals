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
- **Agentic systems = LLM + action-taking; the LLM is the orchestrator**
  (added 2026-09-18, per the primary author) — a new claim, illustrated with
  a new figure (`figures/agentic-loop.svg`: LLM decides → action → environment
  → observes result → back to LLM). Placed first, ahead of the next-token-
  predictor fact, so the reader gets the agentic-systems framing before the
  architecture fact that explains it.

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
- Stays generic — no reference to this course's specific eval harness or
  capstone project — confirmed with the primary author (2026-09-17), so the
  section reads standalone and doesn't need updating if the capstone's design
  changes later.
- "What Goes Wrong Without It" keeps its current hypothetical-but-concrete
  framing (a model inventing a plausible fact, an agent silently dropping an
  instruction) rather than a real transcript — confirmed with the primary
  author (2026-09-17); no sourced example needed.
- Tokenization, sampling controls, and failure-mode material from the source
  `.md` stay as brief mentions here (no dedicated `##` unit) — confirmed with
  the primary author (2026-09-17); see `topic.md` Decisions.
- `prose.md` recombined from 5 headings back to 3 (2026-09-17), and
  `02-motivation.slidecontent.md` was added as the new home for the
  fine-grained 5-unit breakdown. The 5-way split done in round 1 was a fix
  for slide overflow under the old shared-source model; now that
  `slidecontent.md` is separate (see `topic.md` Decisions), the document
  register can go back to fewer, fuller subsections — hallucination and the
  context window as one flowing "what goes wrong" passage, frozen weights and
  sampling as one flowing "where this pays off" passage — while
  `slidecontent.md` keeps one idea per slide.
- `slidecontent.md` has no H1 (2026-09-17, per the primary author) — see
  `topic.md` Decisions for the section-divider-slide removal this was for.
- **`slidecontent.md` consolidated from 5 slides to 2 (2026-09-18), per the
  primary author, to buy back presentation time.** "Why This Matters for
  Agents" now carries just the agentic-systems + next-token-predictor claim
  and the agentic-loop figure; "The Levers This Explains" carries the four
  one-line consequences (hallucination, context window, frozen weights,
  sampling) that used to each have their own slide. `prose.md` is
  untouched — this consolidation is presentation-only; the document keeps
  its fuller 3-subsection treatment.
- Wordsmithed the levers bullet through several passes (2026-09-18): "stop
  being folklore" → "stop being guesswork" → final: "these levers make
  sense instead of feeling arbitrary." The primary author's stated intent:
  once you understand the next-token-predictor mechanism, the important
  parts are more clearly understood — not just "no longer guesswork," but
  positively clear.

## Open questions

- (none outstanding as of 2026-09-17)

## Not doing

- Naming specific mitigations (RAG, memory systems, eval harness design) in
  any depth — this section motivates why they exist, not how to build them;
  that belongs to other tutorials.
- Introducing sampling parameters (temperature, top-p/top-k) by name and
  mechanism — flagged here only as "sampling controls determinism," fully
  unpacked, if at all, in the `03-content` demo.
