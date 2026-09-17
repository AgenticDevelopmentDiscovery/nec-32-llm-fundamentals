# Pedagogical Readiness — Round 1

**Recommendation:** needs revision
The mechanism is taught soundly, but the tutorial's two central promises — figures at every stage and a hands-on demo — are still unbuilt placeholders, and this is a visual, hands-on tutorial by its own proposal.

**Audience read against:** STEM/engineering students who have heard of or lightly used AI/agentic systems and want to understand the mechanism under the hood and use it more effectively — not ML specialists, but comfortable with technical abstraction (vectors, probability distributions).

## Strengths

- The WHAT → WHY → HOW → WHAT ELSE arc is disciplined: each section stays inside its own job (`01-context` never argues, `02-motivation` never teaches mechanism), so the reader is never asked to evaluate a claim before they have the vocabulary for it.
- `02-motivation` does the hard part of motivation well: it grounds each abstract architectural fact in a failure the reader has plausibly already hit as a user (hallucination, a dropped instruction, non-reproducible output), rather than arguing abstractly that "understanding internals is good practice."
- `04-conclusion`'s "What You Can Do Now" matches `01-context` and `topic.md`'s promised capabilities word-for-word — the loop between proposal and delivery closes cleanly at the capability level, even where it doesn't close at the artifact level (see below).

## Weaknesses

- `sections/03-content.prose.md` — both architecture figures are marked `**Figure (not yet embedded):**` and the closing demo is marked `**Demo (not yet built):**`. `topic.md` states plainly this is "a visual tutorial by design" and that the demo exists so the reader "watches the layer-by-layer walkthrough happen on real data instead of taking it on faith." Right now the declared audience gets prose describing a diagram and a script that don't yet exist on the page. For a reader who has never pictured an attention layer, "the encoder attends to itself, the decoder attends to itself and to the encoder" without the actual figure is exactly the kind of asserted-not-illustrated claim the readiness bar exists to catch. This is the single biggest gap between the spine's claims and what's delivered.
- `sections/03-content.prose.md` § Self-Attention — this is the hardest idea in the walkthrough (it's the one that gets a callback from `02-motivation` and is the actual referent of "context window"), yet it gets the same one-paragraph treatment as Tokens and Embeddings, the easiest unit in the section. Query/key/value is introduced by name with no concrete instance — no example sentence, no "here's which tokens end up attending to which and why." A reader who has "lightly used" an LLM but never touched linear algebra on token vectors is asked to hold this abstractly on first pass, right where the section needs to give the hardest material the most room, not the same room.
- `sections/03-content.prose.md` — the demo is the tutorial's only follow-along moment (everything else is read-and-trace, not do), and it's the one piece not yet built. Without it, a reader who wants to check their understanding against something on the page has nothing to run — the tutorial's single "worked detail" moment for the whole architecture is currently a plan, not a result.

## Actionable

1. `sections/03-content.prose.md` § "The Original Transformer: Encoder-Decoder" and § "From Encoder-Decoder to Decoder-Only" — embed the two cited figures now, rather than leaving them as placeholder text. (*why:* this alone likely moves the section from "describes a visual architecture" to "is the visual tutorial `topic.md` promises" — the single highest-leverage fix in the document.)
2. `sections/03-content.prose.md` § "Demo: A Forward Pass, Layer by Layer" — run the demo once against a small model and land real output (tensor shapes per layer, an attention-map snapshot if feasible) instead of a description of the plan. (*why:* this is the only follow-along moment in the tutorial; without executed output it can't be checked against, which is the specific failure mode the readiness bar names.)
3. `sections/03-content.prose.md` § "Self-Attention" — add one concrete instance: a short example sequence (four or five tokens) with a sentence on which tokens end up attending to which and why, alongside the query/key/value description already there. (*why:* moves the hardest concept in the walkthrough from asserted to illustrated, without expanding scope — the multi-head sentence and the "not doing the math" boundary in the spine can stay exactly as they are.)
