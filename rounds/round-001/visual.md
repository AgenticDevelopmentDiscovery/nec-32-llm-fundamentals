# Visual & Multi-Register Exposition — Round 1

**Recommendation:** needs revision
The tutorial's central visual promise is currently undelivered — zero figures exist in the shipped prose, and the single hardest mechanism to picture (self-attention) has none planned at all.

## Slide overflow
- `01-context.prose.md` § What This Tutorial Covers — genuinely dense: one sentence names 3 things covered, the next names 3 things explicitly not covered (each with its own "covered elsewhere" clause), plus a closing capability promise. Four sentences carrying five distinct claims. Worth a look at the rendered page even though it's reported clean.
- `02-motivation.prose.md` § What Goes Wrong Without It — too many ideas: hallucination and context-window truncation are two separate failure modes, each with its own explanation and example, sharing one heading.
- `02-motivation.prose.md` § Where This Understanding Pays Off Most — too many ideas: frozen-weights/retrieval and sampling/determinism are two separate claims (matches the two separate bullets in the sidecar's Claims list) forced under one heading.
- `03-content.prose.md` § Self-Attention — too many ideas: the QKV mechanism, the pronoun-resolution example, the callback to the `02-motivation` context-window claim, and the multi-head aside are four distinct moves in one unit. This is the most overloaded `##` in the document.
- `03-content.prose.md` § Feed-Forward, Residuals, and Normalization — genuinely dense: the heading itself names three concepts, and each gets its own explanation plus a closing "without both, training breaks" claim. Confirmed clean by spot-check, but the density is real and worth watching if any sentence grows.
- `04-conclusion.prose.md` § Where the Field Is Headed — too many ideas / borderline padded: five fronts (scaling, long-context, MoE, multimodality, agentic tool use), each with its own descriptive clause. A single sentence carrying five sub-claims is a lot to hold on one projected slide even at small font.

## Strengths
- `03-content.concepts.md`'s Decisions log shows the team already ran the slide-granularity check this brief asks for — 8 units chosen deliberately, spot-checked page by page, with an explicit fallback ("if a figure proves too dense, split the unit, don't shrink the figure"). That's the process this project is supposed to produce, working as intended.
- Headings across all four sections are short, concrete, and scannable (website register) — a reader landing mid-document via search can tell what a section is about from the heading alone, without needing prior context.
- `topic.md`'s figure policy — reuse and cite primary-source figures (Vaswani et al., the GPT paper line) rather than redraw — is the right call for this register mix: it keeps the document, slide, and site versions visually identical and avoids introducing diagram inconsistencies across three renderings.
- `04-conclusion` § What You Can Do Now mirrors `01-context` § What This Tutorial Covers and `topic.md`'s capability list almost exactly, which is good practice for the website register — a reader who jumps straight to the conclusion gets an accurate, self-contained summary of the promise.

## Weaknesses
- `03-content.prose.md` — all three figures are marked "(not yet embedded)" / "(not yet built)" placeholders. `topic.md` states plainly that "this is a visual tutorial by design," but as shipped there is not a single rendered figure anywhere in the document. Teaching value and caption quality can't be assessed this round because nothing exists to assess.
- `03-content.prose.md` § Self-Attention — no figure is planned for this unit at all. Per `topic.md`'s Scope, the only two figures in the pipeline are the encoder-decoder architecture (Fig. 1) and the decoder-only anchor diagram; nothing covers the query/key/value weighting mechanism itself, which is the single hardest thing in the whole tutorial to hold in your head from prose alone.
- `03-content.prose.md` § Self-Attention and § Stacking Layers to a Next-Token Distribution — both use explicit backward pointers ("from the motivation section," "from the first section") instead of restating the claim. This works in the document register, where the reader has just read those sections, but breaks the presentation register's "no memory of the slide before it" rule and the website register's "reader who lands mid-document knows where they are" rule — on a slide or a search-landed page, "the first section" is not a reachable referent.

## Actionable
1. `03-content.prose.md` § Self-Attention — sketch the missing figure: one token's vector splitting into Query / Key / Value; arrows from every other token's Key into a comparison against that Query, weighted arrows back from each token's Value into a single mixed output vector; highlight one arrow (e.g., a pronoun attending to its antecedent noun) to make the "a token's representation absorbs information from every other token, weighted by relevance" claim visible instead of asserted.
   (*why:* fixes coverage across all three registers — this is the one central mechanism in the tutorial that currently has zero planned visual support)
2. `03-content.prose.md` § Self-Attention and § Stacking Layers to a Next-Token Distribution — replace "the context window claims from the motivation section" and "the ... claim from the first section" with a one-clause restatement of the claim itself (e.g., "the window is the set of tokens self-attention can reach — the same limit that makes older context silently disappear" without naming a section).
   (*why:* repairs presentation and website registers, where a reader cannot resolve "the first section" / "the motivation section" as a pointer)
3. `02-motivation.prose.md` § What Goes Wrong Without It — split into two `##` units, one for hallucination and one for the context window, or cut one down to a single supporting sentence folded into the other.
   (*why:* presentation register — two independently worked failure-mode examples currently compete for one slide)
4. `02-motivation.prose.md` § Where This Understanding Pays Off Most — split frozen-weights/retrieval from sampling/determinism into two units, matching the two separate claims already listed in the sidecar.
   (*why:* presentation register, same overload pattern as item 3)
5. `04-conclusion.prose.md` § Where the Field Is Headed — cut each of the five fronts to a bare noun phrase (drop the explanatory clause per item, or move one item's explanation into a single trailing sentence covering all five) and confirm the rendered slide directly, since five worked sub-claims is the densest list in the document.
   (*why:* presentation register — near-miss on the "one idea per slide" rule even though the spot-check passed)
6. `03-content.prose.md` — embed the two architecture figures (Vaswani Fig. 1, the decoder-only anchor) with self-contained captions before the next round, so teaching value and integration can actually be judged instead of assumed.
   (*why:* document, presentation, and website registers all depend on this — `topic.md`'s "visual tutorial by design" claim is currently a promise, not a delivery)
