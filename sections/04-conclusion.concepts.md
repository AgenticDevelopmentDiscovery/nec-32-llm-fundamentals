# Conclusion — spine

> Note form only; never rendered. See `01-context.concepts.md` for what each
> heading is for.

## Purpose

Say what the reader can now do, matching the promise made in `01-context` and
`topic.md` exactly; give a high-level, thought-provoking look at where the
field is headed; and point to further reading — without introducing new
required material.

## Claims

- The reader can now: explain what a transformer is and why LLMs are built on
  it; trace a token sequence through a decoder-only transformer layer by
  layer; explain how decoder-only relates to the original encoder-decoder
  architecture; and connect architectural facts to an agent's practical
  behaviors and failure modes. (Must agree exactly with `01-context`'s "What
  This Tutorial Covers" and `topic.md`'s "What the reader will be able to
  do" — the panel checks this.)
- Current LLM development is moving on several fronts worth naming at a high
  level: scaling, long-context methods, mixture-of-experts (sparse
  activation), multimodality, and agentic tool use — each a direct extension
  of something the layer-by-layer walkthrough just covered, not an unrelated
  new topic.
- The architecture covered here is stable and widely shared across current
  LLMs, but active research keeps changing pieces of it (attention variants,
  positional schemes, MoE routing) — the reader's mental model is a
  foundation, not a finished picture.

## Decisions

- Chose "Where the Field Is Headed" as a high-level, non-exhaustive survey —
  one line per development, no depth — to keep this section in its role as
  food-for-thought rather than new required material the panel could grade
  as undelivered.
- Folded the source `.md`'s "Further reading" list (Attention Is All You
  Need, the GPT-3 paper, the InstructGPT/RLHF paper, a hands-on resource like
  Karpathy's "Let's build GPT") into "Where to Go Next" as pointers, not
  summaries — consistent with `01-context`'s out-of-scope items pointing
  elsewhere rather than being covered here.

## Open questions

- Overlaps with § Open edges in the prose — but this list is for the team,
  and that section (when drafted) is for the reader. Not everything here is
  ready to ship there.
- Should "Where the Field Is Headed" name specific model families or papers,
  or stay fully generic to avoid the section aging quickly? Naming specifics
  risks staleness sooner than naming categories only.
- Is repeating the "Attention Is All You Need" / GPT-line citations in
  "Where to Go Next" redundant with their use in `03-content`, or useful as a
  consolidated reading list at the end?

## Not doing

- Any new capability claim not already promised in `01-context`/`topic.md` —
  this section recaps and points onward; it does not teach anything new that
  would need its own slide of mechanism.
- Depth on any single current development (e.g. how MoE routing works) —
  each gets at most one line; depth is explicitly out of scope per
  `topic.md`'s "thought-provoking... at high level" framing.
