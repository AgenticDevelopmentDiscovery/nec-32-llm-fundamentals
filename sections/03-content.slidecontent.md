## The Original Transformer: Encoder-Decoder

- "Attention Is All You Need" (Vaswani et al., 2017) — built for machine
  translation
- Two stacks:
  - **Encoder** — reads the whole input, builds a representation
  - **Decoder** — generates output one token at a time
- Decoder attends to two things: its own prior output, and the encoder's
  representation (**cross-attention**)

## The Encoder-Decoder Stack

![Two stacks: encoder reads the input; decoder generates output, attending to its own prior output and — via cross-attention — to the encoder. Adapted from Vaswani et al. (2017), Figure 1.](figures/encoder-decoder.svg){#fig:sc-encoder-decoder width=80%}

## From Encoder-Decoder to Decoder-Only

- Most current LLMs (GPT family, etc.) keep **only the decoder**
- Drop: the encoder, cross-attention
- No separate input to encode — trained purely to predict the next token
  over its own input
- One stack instead of two → trains on *any* text, not just paired
  source/target
- → this is why decoder-only is what scaled

## The Decoder-Only Stack — the Anchor Diagram

![A decoder-only stack, repeated N times. Everything that follows in this section is one piece of this picture — self-attention, feed-forward, residuals/norm, and the final projection are all inside the "×N" block.](figures/decoder-only.svg){#fig:sc-decoder-only width=48%}

## Tokens → Embeddings

- Token id → lookup in **embedding table** → vector
- Starts arbitrary, comes to encode meaning as training proceeds
- Everything downstream happens to these vectors — one per position

![Where we are: the input, before the first layer.](figures/decoder-only-hl-input.svg){#fig:sc-hl-input width=92%}

## Positional Information

- Transformer processes all positions **in parallel** — no built-in sense
  of order
- Positional info added/learned alongside each token's embedding
- Without it: "dog bit man" = "man bit dog" to every later layer

![Where we are: still the input stage — position joins the token embedding here.](figures/decoder-only-hl-input.svg){#fig:sc-hl-input2 width=92%}

## Self-Attention

- Lets a token absorb info from every other token, weighted by relevance
- Each token: *query* vs. every other token's *key* → decides how much of
  its *value* to mix in (worked example: next slide)
- This *is* the context window: only tokens self-attention can reach
- Multiple heads run in parallel, each free to focus on something different

![Where we are: the first block inside the ×N stack.](figures/decoder-only-hl-attention.svg){#fig:sc-hl-attention width=75%}

## Self-Attention, Visualized

![Sentence: "The cat sat on the mat because it was tired." Query/key/value weighting: "it"'s new representation becomes a weighted mix of every other token's value — dominated here by "cat."](figures/self-attention.svg){#fig:sc-self-attention width=55%}

## Feed-Forward, Residuals, Normalization

- **Feed-forward**: transforms each token's vector independently — same
  small network at every position
- **Residual connection**: adds each block's input back to its output —
  keeps a straight path through the whole stack
- **Normalization**: keeps the numbers stable, layer after layer
- Without both: a stack more than a handful of layers deep stops being
  buildable at all

![Where we are: the second block inside the ×N stack.](figures/decoder-only-hl-feedforward.svg){#fig:sc-hl-feedforward width=92%}

## The Decoder Block, Visualized

![One full decoder block: self-attention and feed-forward, each followed by a residual connection (green) and normalization — the unit that the decoder-only stack's "×N" repeats.](figures/residuals.svg){#fig:sc-residuals width=42%}

## Stacking to a Next-Token Distribution

- The block just pictured, repeated ×N — each layer builds a more
  abstract representation
- GPT-2 small: N = 12
- Final layer → one projection → probability distribution over the
  **entire vocabulary**
- Not a single answer — odds. Sampling picks the next token.

![Where we are: this whole block, repeated ×N.](figures/decoder-only-hl-stacking.svg){#fig:sc-hl-stacking width=92%}

## Demo: A Forward Pass, Layer by Layer

- Real GPT-2 small, real sentence: "The cat sat on the mat because it was
  tired"
- Setup: `pip install torch transformers matplotlib`
- Run: `python demo/forward_pass.py`

```
token + positional embedding : (1, 10, 768)
after decoder layer  1        : (1, 10, 768)
...
after decoder layer 12        : (1, 10, 768)
final projection to vocab     : (1, 10, 50257)
```

- Shape never changes layer to layer — only the final projection changes it

## Demo: The Next Token, For Real

```
Next-token distribution after 'tired' (top 5 of 50257):
   '.'     0.273
   ' and'  0.208
   ','     0.190
   ' of'   0.128
   ' from' 0.044
```

- No single "answer" — a `(1, 10, 50257)` tensor of odds
- Generation just samples one

## Demo: Attention, Visualized

![Real GPT-2 small attention weights: the "it" row lights up almost entirely on "cat" — captured on an actual model, not asserted.](figures/demo-attention-map.png){#fig:sc-demo-attention width=48%}
