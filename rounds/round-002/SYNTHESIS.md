# Round 2 — Synthesis

**Panel recommendation:** needs revision
**Seats:** clarity minor polish · pedagogy minor polish · visual needs revision

## Since last round

All seven round-1 docket items were acted on. In order:

1. **Embed the two architecture figures — done**, with a deviation: rather than reusing the source papers' actual figures, the team hand-drew original diagrams adapted from and attributed to them (a copyright-driven call made mid-work, not requested by round 1). The figures exist and are embedded; the deviation itself produced two new findings this round (see Consensus).
2. **Build and run the demo — done.** Real GPT-2 small output (tensor shapes, an actual top-5 next-token distribution, a captured attention map) replaced the "not yet built" placeholder. Both other seats that raised this item last round call it the single biggest improvement since round 1.
3. **Illustrate Self-Attention concretely — done.** A figure and a worked example ("The cat sat on the mat because it was tired," tracing *it* → *cat*) were added.
4. **Make cross-references self-contained — done.** The section-name pointers visual flagged ("from the motivation section," "from the first section") are gone, replaced with self-contained restatements.
5. **Split "What Goes Wrong Without It" — done.** Now two units: Hallucination, The Context Window.
6. **Split "Where This Understanding Pays Off Most" — done.** Now two units: Frozen Weights, Sampling.
7. **Bridge the repeated Transformer-origin recap — done.** `03-content` now opens with "As introduced earlier..." tying back to `01-context`.

Of the three deferred items: grounding "repeated N times" with a concrete number was done anyway (N=12, tied to the demo model) as a side effect of other edits. Trimming `04-conclusion` § "Where the Field Is Headed" was not done — and visual flagged the identical five-fronts-in-one-paragraph density risk again this round, independently. That is a two-round recurrence on an item that has never actually been acted on; see Docket #5.

## Consensus

- **The spine is now factually wrong about what shipped, in two files.** Clarity and pedagogy both independently flagged that `topic.md`'s Decisions and `sections/03-content.concepts.md`'s Decisions still say figures are "reused as-is, not redrawn" and log "8 `##` units confirmed as the right granularity" — but the shipped document has hand-drawn adapted figures and 11 `##` units. Clarity: "tells the next reader something false about the document it sits beside." Pedagogy, independently: "the proposal the panel is supposed to hold the document to no longer describes the document" — and points out `topic.md`'s own guardrail warns about exactly this ("a proposal that no longer matches the tutorial is worse than none"). Two seats naming the same defect, for the same reason, is the strongest signal in this round's reports.
- **The pivot to hand-drawn figures was never followed through to the captions.** Clarity notes the encoder-decoder figure is captioned "Adapted from Vaswani et al. (2017), Figure 1," but the decoder-only and self-attention figures carry no citation at all, contradicting `topic.md`'s own stated policy that "each figure carries a citation back to its source paper." This is the reader-facing symptom of the same root cause as the spine-staleness finding above: the mid-round decision to redraw rather than reuse figures was made and partly executed, but never reconciled everywhere it touches.

## Conflicts

- none

## Docket

1. **Reconcile the figure-sourcing policy everywhere it's stated** — `topic.md` (Decisions), `sections/03-content.concepts.md` (Decisions), and the figure captions in `sections/03-content.prose.md`
   *Raised by:* clarity, pedagogy · *Effort:* small
   Decide and record the actual policy now in effect (hand-drawn diagrams, adapted from and attributed to the source papers — not "reused as-is"), update both Decisions logs to say so, update the confirmed unit count from 8 to 11, correct the demo status from "not yet built," and add matching attribution to the decoder-only and self-attention captions so all three figures are cited consistently. This is one root decision with two visible symptoms (stale spine, inconsistent captions) — fixing the policy statement and applying it to the captions is a single pass.

2. **Add a figure for Feed-Forward, Residuals, and Normalization** — `sections/03-content.prose.md` § "Feed-Forward, Residuals, and Normalization"
   *Raised by:* visual · *Effort:* medium
   A small diagram of one decoder block — input → self-attention → (+, residual) → norm → feed-forward → (+, residual) → norm → output, with two curved skip-connection arrows — following the established text-unit-then-"...-Visualized"-unit pattern already used for the other three figures. Visual's stated reason for the "needs revision" tier leads with this exact gap: residual/normalization is "the most inherently relational idea in the walkthrough" and currently has no image, unlike everything else in the section.

3. **Remove the unexplained training vocabulary in the same unit** — `sections/03-content.prose.md` § "Feed-Forward, Residuals, and Normalization"
   *Raised by:* pedagogy · *Effort:* small
   "so information and **gradients** have a direct path... stops **training** reliably" assumes vocabulary (gradients, training stability) that `topic.md` explicitly scopes out. Pedagogy: fixing this "alone likely moves the section from minor-polish to ready-as-is." Natural to do alongside #2 since both land on the same `##` unit, but they are different defects (missing image vs. unexplained term), not one fix.

4. **Point back to the decoder-only anchor figure from the units that teach pieces of it** — `sections/03-content.prose.md` §§ "Self-Attention," "Feed-Forward, Residuals, and Normalization," "Stacking Layers to a Next-Token Distribution"
   *Raised by:* visual · *Effort:* small
   `topic.md`'s own Shape section calls the decoder-only figure "the anchor visual — reused/annotated across multiple `##` units as the walkthrough moves through it," but it appears once and is never referenced again. Add one clause per unit (e.g. "the block in Figure 2") — not a repeated image.

5. **Trim or restructure "Where the Field Is Headed"** — `sections/04-conclusion.prose.md`
   *Raised by:* visual · *Effort:* small · *recurring: flagged in round 1 (deferred) and again in round 2*
   Five fronts (scaling, long-context, MoE, multimodality, agentic tool use), each with its own gloss, compressed into one paragraph — "reads as a disguised bullet list." This has now been named independently in two rounds without ever being acted on; it stays cheap to fix and the recurrence itself is the reason it's promoted into the docket rather than deferred a third time.

6. **Name "cross-attention" before its first (caption) appearance** — `sections/03-content.prose.md` § "The Original Transformer: Encoder-Decoder"
   *Raised by:* clarity · *Effort:* small
   The term currently appears for the first time inside a figure caption two slides later ("Drop the encoder and cross-attention..."), with no prior anchor. The mechanism is already described in this earlier unit ("attending... to the encoder's representation") — just needs the name attached.

7. **Surface the demo's setup instructions into the rendered document** — `sections/03-content.prose.md` § "Demo: A Forward Pass, Layer by Layer"
   *Raised by:* pedagogy · *Effort:* small
   The setup (`pip install torch transformers matplotlib`, then `python demo/forward_pass.py`) already exists in `demo/forward_pass.py`'s docstring but never reaches the PDF/slides/site. `topic.md` calls this a "hands-on demo" — a reader who wants to follow along, not just read captured output, currently has to find the repo file first.

## Deferred

- Self-Attention, Visualized caption self-containedness — visual; the caption assumes the reader just saw the preceding slide's example sentence and QKV vocabulary, which breaks the "no memory of the slide before it" rule for a reader who lands there first. Real but the lowest-severity of this round's four visual findings.

## Do next

1. Reconcile the figure-sourcing policy across `topic.md`, `03-content.concepts.md`, and the captions (docket #1).
2. Add the Feed-Forward/Residuals/Normalization figure and cut the unexplained training vocabulary in the same unit (docket #2 + #3).
3. Trim "Where the Field Is Headed" (docket #5) — cheap, and this is its second round on the table.

Docket #1 is listed first because it's the cheapest fix and because an inaccurate spine actively misleads whoever reads it next — including next round's reviewers, who are briefed to trust it. #2+#3 together are what's keeping the panel recommendation at "needs revision" rather than "minor polish," per visual's and pedagogy's own stated reasoning. #5 is promoted ahead of the remaining small items specifically because it is a two-round recurrence on an item that costs almost nothing to fix.

## Panel health

- nothing to report
