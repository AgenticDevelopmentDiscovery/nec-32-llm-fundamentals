## What You Can Do Now

- Explain what a transformer is, and why LLMs are built on one
- Trace a token through a decoder-only transformer, layer by layer:
  embedding → positional info → self-attention → feed-forward → residuals
  → normalization
- Explain how decoder-only relates to the original encoder-decoder
  architecture
- Connect architecture facts (context window, frozen weights, sampling) to
  how an agent actually behaves

## Where the Field Is Headed

- **Scaling** — bigger models, more data, capability keeps improving
- **Long-context** — token budgets pushing from thousands to millions
- **Mixture-of-experts** — only a fraction of parameters active per token
- **Multimodality** — same next-token machinery, beyond text
- **Autonomous, multi-step tool use** — agents chaining actions with less
  human intervention per step
- Each of these extends something you just saw — not a new idea

## Where to Go Next

- **How a model becomes a helpful assistant:** the InstructGPT / RLHF paper
- **In-context learning at scale:** "Language Models are Few-Shot
  Learners" (GPT-3 paper)
- **Hands-on, from scratch, in code:** Andrej Karpathy, "Let's build GPT"
