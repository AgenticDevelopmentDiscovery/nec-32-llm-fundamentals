# Context

<!-- Every `##` becomes one slide. One idea each. -->

## What a Transformer Is

A large language model (LLM) is a neural network — almost always a
**Transformer** — trained to do one thing: predict the next token in a
sequence. Before the model sees any text, a *tokenizer* breaks it into
tokens, chunks that are often smaller than a whole word. The model takes a
sequence of token ids and outputs a probability distribution over what comes
next. Generation is **autoregressive**: sample a token from that
distribution, append it, feed the longer sequence back in, repeat. There is
no database lookup inside the model, and no symbolic reasoning engine — just
a large, learned function mapping token sequences to next-token
probabilities.

## Where Transformers Came From

The Transformer was introduced in 2017, in "Attention Is All You Need," to
solve machine translation — mapping a sentence in one language to a sentence
in another. Before it, the dominant approach used recurrent networks that
processed a sequence one token at a time, in order, which made them slow to
train and prone to losing track of earlier tokens over long sequences. The
Transformer replaced recurrence with **attention**, a mechanism that lets the
model look at an entire sequence at once. That one change is a large part of
why the architecture scaled to the model sizes and datasets in use today.

## What This Tutorial Covers

This tutorial covers what a transformer is, why understanding it matters for
building agents, and — the bulk of it — how the decoder-only architecture
used by most current LLMs processes data, layer by layer. It closes with a
look at where the field is headed. It does **not** cover: how a model's
weights are trained, covered by a different tutorial elsewhere in the course;
how a tokenizer is built, likewise covered elsewhere; or fine-tuning, RLHF,
and prompt-engineering technique, each its own tutorial in this course. By
the end, you'll be able to trace a token through the architecture and explain
why an agent behaves the way it does, not just how to prompt one.
