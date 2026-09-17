# Context — spine

> The register that does not ship. This file is never rendered into the document,
> the slides, or the site — but the reviewers read it, and they judge whether what
> it promises is turning into prose.
>
> Keep it in note form. Prose here is a sign you wrote in the wrong file.

## Purpose

Say WHAT a transformer is, in plain enough terms that the reader can picture
it before any argument for why it matters, and name what this tutorial will
and will not cover.

## Claims

- An LLM is, almost always, a Transformer: a neural network trained to
  predict the next token in a sequence.
- Text is broken into tokens by a tokenizer before the model ever sees it;
  the model operates on token ids, not characters or words.
- Generation is autoregressive: the model outputs a probability distribution
  over the next token, one token is sampled, appended, and fed back in.
- There is no symbolic reasoning engine or database lookup inside the model —
  only a large learned function from token sequences to next-token
  probabilities.
- This tutorial's center of mass is the architecture (HOW a transformer
  processes data); training mechanics, tokenizer internals, and
  fine-tuning/RLHF/prompting are named but not covered here — each belongs to
  a different tutorial elsewhere in the course.

## Decisions

- Defined the transformer by what it does (next-token prediction over
  tokens) rather than by its historical motivation (machine translation) —
  the definition seeds this section; the origin gets two or three sentences,
  not an argument. Chosen to keep WHAT and WHY from blurring into each other,
  per the course's WHAT-before-WHY guardrail.
- Chose to state each out-of-scope item explicitly, one line, rather than
  stay silent — per the primary author's request that an omission read as
  deliberate rather than as a gap. Each pointer names which other course
  tutorial covers it.
- Out-of-scope pointers stay generic ("covered by a different tutorial
  elsewhere in the course") rather than naming specific tutorial
  numbers/titles — confirmed with the primary author (2026-09-17); can be
  swapped for real names once the course syllabus is finalized, without
  blocking this draft.
- "Where Transformers Came From" keeps its current one-clause mention of the
  translation origin and the recurrence-to-attention shift, without naming
  "encoder-decoder" — confirmed with the primary author (2026-09-17); the
  full architectural story stays reserved for `03-content`'s opening.
- This section gained a sibling `01-context.slidecontent.md` (2026-09-17, see
  `topic.md` Decisions for why the presentation split off `prose.md`
  entirely). `prose.md` here needed no rework for the split — it has no
  figures and was never distorted by the old shared-source slide constraint
  — so it stays the long-form register unchanged; `slidecontent.md` is new
  talking-points content covering the same three claims at slide pace.

## Open questions

- (none outstanding as of 2026-09-17)

## Not doing

- Explaining next-token probability sampling mechanics (temperature,
  top-k/top-p) — teased here only as "a distribution, not a single answer";
  fully covered where it connects to determinism, in `02-motivation` and the
  `03-content` demo.
- Any architecture diagram here — figures are reserved for `03-content`,
  where the layer-by-layer walkthrough needs them. This section is text-only
  scene-setting.
