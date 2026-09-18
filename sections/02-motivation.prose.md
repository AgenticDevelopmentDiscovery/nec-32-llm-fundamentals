# Motivation

## Why Architecture Understanding Matters for Agents

An agentic system, at bottom, is an LLM plus the ability to take actions —
call a tool, run code, read back the result — with the LLM as the
orchestrator deciding what happens next at every step. Every capability and
every failure mode your agent exhibits traces back to this mechanism. Once
you know an LLM is a next-token predictor operating over a fixed window of
tokens, with weights that don't change while it's running,
the levers you actually have — context engineering, grounding, prompt
design, sampling — stop being folklore and start being consequences you can
reason about. That's the case for sitting through the architecture
walkthrough that follows.

## What Goes Wrong Without It

**Hallucination** is not a bug that a future model update will quietly fix —
it's the direct consequence of an objective that optimizes for likely
tokens, not true ones. A model will confidently complete a sentence with a
plausible-sounding fact it never verified, because "plausible" is exactly
what it was trained to produce. The **context window** is just as
unforgiving, for a different reason: it's a hard token budget, and once a
conversation or a retrieved document exceeds it, older content doesn't fade
gracefully — it's simply gone. An agent that silently drops an instruction
from three turns ago is usually just out of room.

## Where This Understanding Pays Off Most

Weights are frozen at inference: the model is not learning from your prompt,
so anything an agent "remembers" mid-conversation lives only in the context
window you feed it — this is *why* retrieval and memory systems exist at
all. Sampling controls (temperature, top-p/top-k) set how deterministic an
agent's output is, which matters when you need a reproducible eval harness:
a temperature-0 agent gives repeatable results, a temperature-1.2 agent
gives a different answer every run.
