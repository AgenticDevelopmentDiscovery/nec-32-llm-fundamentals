## The Original Transformer: Encoder-Decoder

- "Attention Is All You Need" (Vaswani et al., 2017) — built for machine
  translation
- Two stacks:
  - **Encoder** — reads the whole input, builds a representation
  - **Decoder** — generates output one token at a time

![Two stacks: encoder reads the input; decoder generates output, attending to its own prior output and — via cross-attention — to the encoder. Adapted from Vaswani et al. (2017), Figure 1.](figures/encoder-decoder.svg){#fig:sc-encoder-decoder width=62%}

## From Encoder-Decoder to Decoder-Only

- Most current LLMs (GPT family, etc.) keep **only the decoder**
- Drop: the encoder, cross-attention
- No separate input to encode — trained purely to predict the next token
  over its own input

![The decoder-only stack — the anchor diagram for the rest of this section.](figures/decoder-only.svg){#fig:sc-decoder-only width=20%}

## Tokens → Embeddings

- Token id → lookup in **embedding table** → vector
- Comes to encode meaning as training proceeds — the classic example:

![king - man + woman is close to queen.](figures/embedding-analogy.svg){#fig:sc-embedding-analogy width=26%}

![Where we are: the input, before the first layer.](figures/decoder-only-hl-input.svg){#fig:sc-hl-input width=78%}

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

## From the Stack to Next-Token Probabilities

- After N layers (GPT-2 small: N = 12), one **Final Norm** — outside the
  loop, the only norm that isn't repeated per layer
- **Linear + Softmax** projects each position's vector onto the
  vocabulary — turning it into a probability distribution
- Output: odds over every possible next token, not a single answer —
  sampling is what picks one

![Where we are: one final norm, then the projection to the vocabulary.](figures/decoder-only-hl-output.svg){#fig:sc-hl-output width=92%}

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
