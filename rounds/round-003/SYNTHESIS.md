# Round 3 — Synthesis

**Panel recommendation:** minor polish
**Seats:** clarity minor polish · pedagogy minor polish · visual minor polish

## Since last round

Six of round 2's seven docket items are done; one is not, for a third round running.

1. **Reconcile the figure-sourcing policy everywhere it's stated — done.** `topic.md`, `03-content.concepts.md`, and all three figure captions now consistently describe hand-drawn, attributed figures; the unit count and demo status are current.
2. **Add a Feed-Forward/Residuals/Normalization figure — done.** `figures/residuals.svg` exists, is embedded as Figure 4 in `prose.md`, and (per this round's `concepts.md` log) survived several further correction passes to get its architecture exactly right.
3. **Remove unexplained training vocabulary — done.** "Gradients" and "stops training reliably" are gone from `03-content`; replaced with "keeps a straight path through the whole stack" / "stops being buildable at all."
4. **Point back to the anchor figure from units that teach pieces of it — done.** Self-Attention, Feed-Forward, and Stacking Layers all now reference Figure 2 or Figure 4 explicitly.
5. **Trim or restructure "Where the Field Is Headed" — not done.** `04-conclusion.prose.md` is unchanged: still one paragraph naming five fronts (scaling, long-context, MoE, multimodality, agentic tool use), each with its own gloss. This item was deferred in round 1, promoted to round 2's docket and "Do next" list, and is now unfixed for a third consecutive round. No round-3 reviewer re-raised it — expected, since reviewers are deliberately not shown the prior docket and this recurrence is the aggregator's job to track, not theirs — but the item itself is still open and belongs back on the team's radar even though it isn't carried into this round's Docket below (no current-round seat raised it, and the docket only draws from what was actually raised this round).
6. **Name "cross-attention" before its first appearance — done.** Named explicitly in prose's Encoder-Decoder unit, not just in a later caption.
7. **Surface the demo's setup instructions into the rendered document — done, with a new wrinkle.** The instructions are in `prose.md` and `slidecontent.md` now, but pedagogy flags this round that they're the *simplified* instructions, not the ones `demo/forward_pass.py`'s own docstring recommends (a venv and a CPU-only torch wheel) — see Docket below, item deferred.

Deferred item from round 2 (Self-Attention, Visualized caption self-containedness) — **done.** The slide caption now states the example sentence directly rather than referring back to a prior slide.

## Consensus

None this round at the level the rule requires — no single passage or defect was named independently by two or more seats. This is itself a mild positive signal: three seats reading the same four sections converged on zero overlapping complaints, which suggests the remaining issues are scattered and shallow rather than concentrated in one place a reader would actually stumble on repeatedly. The closest thing to a pattern is that both clarity and visual each found a *different* register-drift gap in the back half of `03-content` (a terminology gap on "softmax," a missing architecture fact on normalization) — worth noting as the same *kind* of problem recurring in the same neighborhood of the document, even though they're two distinct items below, not one.

## Conflicts

- none

## Docket

1. **Fix the Feed-Forward/Residuals/Normalization slide: likely overflow, and a missing architecture fact** — `03-content.slidecontent.md` § "Feed-Forward, Residuals, Normalization"
   *Raised by:* visual · *Effort:* small
   Two fixes on the same slide, worth doing in one pass. First: cut or fold the fourth bullet ("Without both: a stack more than a handful of layers deep stops being buildable at all") into the residual-connection bullet — it restates urgency the first two bullets already carry, and is the likely cause of overflow against the slide's 92%-width anchor figure (the densest bullet-plus-figure combination in the deck). Second: add one clause to the Normalization bullet stating explicitly that only self-attention's residual gets normed ("but only after self-attention, not after feed-forward") — this fact lives in `prose.md` and is encoded structurally in the figure (one "Norm" box, one bare "+"), but a presenter working from the slide deck alone has no way to recover it from the slide's own words, for a fact that took several correction passes this project to get right everywhere else. Check the rendered page after.

2. **Close the topic.md-promised temperature callback in the demo** — `03-content.prose.md` / `03-content.slidecontent.md`, Demo section
   *Raised by:* pedagogy · *Effort:* small
   `topic.md`'s Demo section explicitly promises "a one-line callback" to sampling temperature, since it's "already covered under Why." It isn't there — "temperature" appears zero times in either `03-content` file. Add one clause tying the demo's `torch.softmax` sampling step back to the temperature lever `02-motivation` already spent a paragraph on.

3. **Reconcile the spine's wordsmith claim with what prose.md actually says** — `02-motivation.concepts.md` / `02-motivation.prose.md`
   *Raised by:* pedagogy · *Effort:* small
   The spine's Decisions log records a specific final wording ("these levers make sense instead of feeling arbitrary") as the outcome of a wordsmithing pass, but `prose.md` still reads the earlier "stop being folklore and start being consequences you can reason about." Either apply the spine's own final wording to the prose sentence, or correct the decision log to describe what's actually there. The sentence itself isn't broken for today's reader — the spine asserting a delivery that didn't happen is the defect, and it's exactly the kind of drift that makes a spine untrustworthy as a record for the next round to trust at face value.

4. **Make "softmax" appear in both registers, or neither** — `03-content.prose.md` § "Stacking Layers to a Next-Token Distribution" / `03-content.slidecontent.md` § "From the Stack to Next-Token Probabilities"
   *Raised by:* clarity · *Effort:* small
   The slide names the operation "**Linear + Softmax**"; the parallel prose passage only says "one more projection... turning it into a probability distribution" and never uses the word "softmax" anywhere in the document. A reader who hits the slide term has nothing in the document to check it against. Either add one clause defining softmax in `prose.md`, or drop the named operation from the slide to match the document's level of abstraction.

5. **Fix the dangling pronoun in the section's opening claim** — `02-motivation.prose.md` § "Why Architecture Understanding Matters for Agents"
   *Raised by:* clarity · *Effort:* small
   "Every capability and every failure mode your agent exhibits traces back to this mechanism" — "this mechanism" currently reads as pointing at the orchestration loop described in the sentence just before it, not the next-token-prediction mechanism the rest of the paragraph is actually about. Name the referent directly (e.g., "traces back to the next-token-prediction mechanism underneath it").

6. **Add a one-clause transition into the layer-by-layer walkthrough** — `03-content.prose.md`, between § "From Encoder-Decoder to Decoder-Only" and § "Tokens and Embeddings"
   *Raised by:* clarity · *Effort:* small
   Every other section boundary in the document is explicitly signposted; this is the one seam where the argument silently shifts from describing the architecture to walking through it stage by stage. Add one clause marking the pivot (e.g., "From here, follow one token through the stack, stage by stage.").

7. **Resolve "agentic tool use" naming both a settled premise and a future frontier** — `04-conclusion.prose.md` § "Where the Field Is Headed"
   *Raised by:* clarity · *Effort:* small
   `02-motivation.prose.md` opens by defining an agentic system as, presently, "an LLM plus the ability to take actions" — the course's foundational premise. `04-conclusion.prose.md` then lists "**agentic tool use**, where the model's output drives actions in the world" among the field's open frontiers. Either drop it from the forward-looking list, or reword it to name something genuinely still emerging (e.g., more autonomous, multi-step tool use), so the same term doesn't mean "settled foundation" in one section and "open frontier" in another.

## Deferred

- Align the demo's stated setup instructions with `demo/forward_pass.py`'s own docstring (venv + CPU-only torch wheel) — pedagogy; real but medium effort, and it's a machine-dependent slowdown, not a hard failure, for the naive command.
- Add a figure for the context window (fixed token slots, oldest token dropping off, a "gone, not faded" label) in `02-motivation` — visual; the highest-payoff unillustrated idea flagged this round, but drawing a new figure is real work, not a quick edit.
- Split `03-content.slidecontent.md` § "Tokens → Embeddings," which currently carries two unrelated figures (the embedding-analogy parallelogram and the anchor "where we are" diagram) under one heading — visual; worth doing but not urgent, since the anchor figure repeats again one slide later anyway.
- `04-conclusion.prose.md` § "Where the Field Is Headed" density — not raised by any seat this round, but unresolved for three rounds running (see *Since last round*). Not added to the Docket above per this round's rule against introducing findings no current seat raised, but it should not be allowed to quietly drop off the team's list a fourth time.

## Do next

1. Fix the Feed-Forward/Residuals/Normalization slide (docket #1) — cheapest fix with the clearest reader-facing stakes: a possible visual break, plus a fact the team has already spent real effort getting right elsewhere going unstated in this one place.
2. Close the temperature callback gap in the demo (docket #2) — pedagogy's own top pick, and the one fix explicitly identified as moving the section from "minor polish" toward "ready as-is."
3. Reconcile the spine's wordsmith claim with `prose.md` (docket #3) — cheap, and it's a defect in the method's own record-keeping, not just the document; left alone, it undermines the next round's ability to trust `concepts.md` at face value.

Items 4–7 are all small, real, and worth doing in the same pass as the above if there's room — none of them individually changes the panel's recommendation, but "minor polish" is exactly the tier where several small, precise fixes add up fastest.

## Panel health

- nothing to report. All three seats read all three registers, established the declared audience before judging, cited specific passages rather than general impressions, and stayed within their three-to-five-item budgets. This is the first round where all three seats independently landed on the same tier (minor polish) — a genuine signal of convergence, not an averaging artifact, since the rule against averaging was not in play (there was nothing to average).
