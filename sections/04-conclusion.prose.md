# Conclusion

<!-- Every `##` becomes one slide. One idea each. -->

## What You Can Do Now

You can now explain what a transformer is and why LLMs are built on one;
trace a token sequence through a decoder-only transformer layer by layer —
embedding, positional information, self-attention, feed-forward, residuals,
normalization; explain how that decoder-only shape relates to the original
encoder-decoder architecture; and connect architectural facts — a fixed
context window, frozen weights at inference, stochastic sampling — to the
behaviors and failure modes an agent built on an LLM will actually exhibit.

## Where the Field Is Headed

The architecture in this tutorial is stable and shared across most current
LLMs, but the field keeps changing pieces of it. A few fronts worth knowing
at a glance: **scaling** — larger models trained on more data keep improving
capability, for reasons still not fully explained; **long-context** methods
that push the token budget from thousands of tokens to millions;
**mixture-of-experts**, where only a fraction of the model's parameters
activate for a given token; **multimodality**, extending the same
next-token machinery beyond text to images, audio, and more; and **agentic
tool use**, where the model's output drives actions in the world, not just
more text. Each of these is a direct extension of something in this
tutorial's walkthrough, not an unrelated new idea.

## Where to Go Next

For the architecture itself: "Attention Is All You Need" (Vaswani et al.,
2017) — the paper this tutorial's figures come from. For how a model like
this becomes a helpful assistant rather than a raw next-token predictor: the
InstructGPT / RLHF paper. For in-context learning at scale: "Language Models
are Few-Shot Learners," the GPT-3 paper. And for a from-scratch, hands-on
walkthrough of everything covered here, in code: Andrej Karpathy's "Let's
build GPT."
