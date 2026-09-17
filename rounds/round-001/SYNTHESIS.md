# Round 1 — Synthesis

**Panel recommendation:** needs revision
**Seats:** clarity needs revision · pedagogy needs revision · visual needs revision

## Since last round

First round — no prior docket.

## Consensus

- **The two architecture figures in `03-content.prose.md` are marked "(not yet embedded)" and the demo is marked "(not yet built)."** All three seats independently named this as the central defect. `topic.md` states plainly that this is "a visual tutorial by design" with figures reused from primary sources and a hands-on demo so the reader "watches the layer-by-layer walkthrough happen on real data instead of taking it on faith" — as shipped, none of that exists on the page yet. Clarity called it "a delivery gap in the shipped register, not a polish issue"; pedagogy called it "the single biggest gap between the spine's claims and what's delivered"; visual could not even assess figure teaching value or integration because "nothing exists to assess." This single finding is why all three seats landed on "needs revision" rather than "minor polish."
- **Self-Attention is under-illustrated for how hard it is.** Pedagogy and visual both flagged this unit independently, for related but distinct reasons: pedagogy notes it gets the same one-paragraph treatment as the easiest unit in the section (Tokens and Embeddings), with query/key/value asserted but never made concrete; visual notes that of the two figures currently planned (encoder-decoder, decoder-only anchor), neither covers self-attention itself — the one mechanism hardest to hold in your head from prose alone, and the actual referent of the "context window" callback the tutorial leans on twice.
- **The demo needs to actually exist before the next round**, not just be described. Clarity and pedagogy both flagged this: pedagogy calls it "the tutorial's only follow-along moment... currently a plan, not a result"; clarity notes ending the tutorial's main section on "not yet built" undercuts the "what you can do now" landing that `04-conclusion` immediately makes.

## Conflicts

- none

## Docket

1. **Embed the two architecture figures in `03-content`** — `sections/03-content.prose.md` § "The Original Transformer: Encoder-Decoder" and § "From Encoder-Decoder to Decoder-Only"
   *Raised by:* clarity, pedagogy, visual · *Effort:* medium
   Source and embed the Vaswani et al. (2017) Figure 1 (encoder-decoder) and a decoder-only anchor diagram from the GPT paper line, per `figures/README.md`'s convention and `topic.md`'s reuse-and-attribute decision. If either genuinely cannot be ready this round, replace the bracketed placeholder with a one-line note that reads as an intentional, tracked deferral rather than leaving "(not yet embedded)" in shipped prose.

2. **Build and run the demo** — `sections/03-content.prose.md` § "Demo: A Forward Pass, Layer by Layer"
   *Raised by:* clarity, pedagogy · *Effort:* medium
   Run the layer-by-layer tensor-shape / attention-map inspection against a small real model (e.g. GPT-2 small) as already decided in `topic.md`, and land actual output in the slide — not a description of the plan. This is the tutorial's only follow-along moment; without executed output there is nothing for the declared audience to check their understanding against.

3. **Illustrate Self-Attention concretely** — `sections/03-content.prose.md` § "Self-Attention"
   *Raised by:* pedagogy, visual · *Effort:* medium
   Add a figure showing one token's vector splitting into Query/Key/Value, weighted arrows from every other token's Key/Value into it, with one arrow highlighted (e.g. a pronoun attending to its antecedent) — plus a short concrete example (4–5 tokens) naming which tokens end up attending to which, and why. This is the hardest concept in the walkthrough and currently the only one with neither a planned figure nor a worked instance.

4. **Make cross-references self-contained across all three registers** — `sections/03-content.prose.md` § "Self-Attention" and § "Stacking Layers to a Next-Token Distribution"
   *Raised by:* visual · *Effort:* small
   Replace "the context window claims from the motivation section" and "the ... claim from the first section" with a one-clause restatement of the claim itself, with no section pointer. These phrasings work in the document register but break presentation ("no memory of the slide before it") and website ("reader lands mid-document, needs to know where they are").

5. **Split `02-motivation` § "What Goes Wrong Without It"** — `sections/02-motivation.prose.md`
   *Raised by:* visual · *Effort:* small
   Hallucination and context-window truncation are two separate failure modes, each already worked with its own explanation and example, sharing one heading. Split into two `##` units or cut one down to a single supporting sentence folded into the other.

6. **Split `02-motivation` § "Where This Understanding Pays Off Most"** — `sections/02-motivation.prose.md`
   *Raised by:* visual · *Effort:* small
   Frozen-weights/retrieval and sampling/determinism are two separate claims — already listed as two separate bullets in the section's own spine — forced under one heading. Split to match.

7. **Bridge the repeated Transformer-origin recap** — `sections/01-context.prose.md` § "Where Transformers Came From" and `sections/03-content.prose.md` § "The Original Transformer: Encoder-Decoder"
   *Raised by:* clarity · *Effort:* small
   Both sections open by re-establishing "Attention Is All You Need" (2017) and the machine-translation motivation with no cross-reference between them. Add one clause in `03-content` tying back to `01-context` (e.g. "As introduced earlier... here is the shape that gave it that capability") so the repeat reads as a deliberate return at higher resolution rather than a duplicated opening.

## Deferred

- Add a signpost sentence at the "From Encoder-Decoder to Decoder-Only" → "Tokens and Embeddings" seam in `03-content` — clarity; the one un-signposted transition in an otherwise well-signposted section, but lower leverage than the figure/demo gaps above.
- Trim `04-conclusion` § "Where the Field Is Headed" to reduce its five-fronts-in-one-sentence density — visual; flagged as a near-miss, not a confirmed overflow.
- Ground "repeated N times" with a concrete number in `03-content` § "Stacking Layers to a Next-Token Distribution" — clarity; minor, the one unexplained symbol in an otherwise plain-language section.

## Do next

1. Embed the two architecture figures in `03-content` (docket #1).
2. Build and run the demo, landing real output in the slide (docket #2).
3. Add the Self-Attention figure and a concrete worked example (docket #3).

These three items are what all three seats' "needs revision" recommendation is actually about — they are also the three places where `topic.md`'s explicit promise ("a visual tutorial by design," a demo so the reader isn't "taking it on faith") is furthest from what currently ships. Everything else on the docket is real but secondary.

## Panel health

- nothing to report
