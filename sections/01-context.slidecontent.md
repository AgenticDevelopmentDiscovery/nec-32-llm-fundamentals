# Context

<!-- Talking points and figures, not paragraphs. Every `##` becomes one slide.
     Written for the deck, not reflowed from 01-context.prose.md. -->

## What a Transformer Is

- An LLM is (almost always) a **Transformer**: a neural net trained to
  predict the next token
- Text → tokens (subword chunks, not whole words) → token ids
- Model outputs a **probability distribution** over the next token
- **Autoregressive**: sample → append → feed back in → repeat
- No database, no symbolic reasoning — a learned function, token
  sequences in, probabilities out

## Where Transformers Came From

- 2017, "Attention Is All You Need" — built to solve machine translation
- Before: recurrent networks, one token at a time, slow, forgot long-range
  context
- The fix: **attention** — look at the whole sequence at once
- That one change is why this architecture scaled

## What This Tutorial Covers

- **What** a transformer is → **Why** it matters for agents → **How** it
  processes data, layer by layer → **What's next** in the field
- By the end: trace a token through the architecture, explain *why* an
  agent behaves the way it does
- Not covered here (see the other tutorials in this course):
  - how the weights are trained
  - how the tokenizer is built
  - fine-tuning, RLHF, prompting technique
