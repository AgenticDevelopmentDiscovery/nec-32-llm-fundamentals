## Why This Matters for Agents

- LLM = next-token predictor, fixed context window, frozen weights
- Once you know that, your levers stop being folklore:
  - context engineering
  - grounding
  - prompt design
  - sampling
- Everything below is a *consequence* of the mechanism, not a separate rule
  to memorize

## Hallucination: Confident, Not Correct

- Not a bug a model update quietly fixes
- Direct consequence of the training objective: **likely tokens, not true
  ones**
- A model completes a sentence with a plausible fact it never verified —
  because "plausible" is what it optimizes for

## The Context Window: A Hard Budget

- Fixed token budget — not a soft limit
- Once a conversation exceeds it, older content is **gone**, not faded
- Symptom: agent silently drops an instruction from three turns ago
- → it's just out of room

## Frozen Weights → Why Retrieval Exists

- Weights don't change at inference — the model learns nothing from your
  prompt
- Everything an agent "remembers" mid-conversation = what's in the context
  window, full stop
- This is *why* retrieval and memory systems exist

## Sampling and Reproducibility

- Temperature / top-p / top-k control how deterministic output is
- Temperature 0 → repeatable results (good for eval harnesses)
- Temperature 1.2 → different answer every run
- Matters directly for anyone building reproducible evals
