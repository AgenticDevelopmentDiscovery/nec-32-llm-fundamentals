## Why This Matters for Agents

- **Agentic systems = LLM + action-taking** — the LLM orchestrates, because
  it's a next-token predictor with a fixed context window and frozen weights

![Agentic system = LLM + action-taking: the LLM decides, the system acts in the world, results feed back in — the LLM orchestrates the loop.](figures/agentic-loop.svg){#fig:sc-agentic-loop width=48%}

## The Levers This Explains

- **Hallucination**: optimizes for likely tokens, not true ones — confidently
  wrong by design, not by bug
- **Context window**: a hard budget — once exceeded, older content is gone,
  not faded
- **Frozen weights**: nothing is learned from your prompt — this is *why*
  retrieval and memory exist
- **Sampling**: temperature controls determinism — critical for reproducible
  evals
