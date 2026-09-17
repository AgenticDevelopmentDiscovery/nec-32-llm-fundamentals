# Content

<!-- Every `##` becomes one slide. One idea each.
     This is the main portion of the tutorial and the section most likely to
     need more `##` units than shown below. Add them freely — each new
     heading is a new slide, and splitting is how you find the joints. -->

## The Original Transformer: Encoder-Decoder

As introduced earlier, the Transformer replaced recurrence with attention to
solve machine translation — here is the shape that gave it that capability.
The architecture from "Attention Is All You Need" (Vaswani et al., 2017) has
two stacks: an **encoder**, which reads the entire input sequence and builds
a representation of it, and a **decoder**, which generates the output
sequence one token at a time, attending both to its own previous outputs and
to the encoder's representation. This shape fit translation naturally — a
clear source sequence and a target sequence that are meaningfully different
from one another.

## The Encoder-Decoder Stack, Visualized

![The original Transformer's two stacks: an encoder that reads the whole input, and a decoder that generates output tokens one at a time, attending to its own prior output and to the encoder's representation. Adapted from Vaswani et al. (2017), Figure 1.](figures/encoder-decoder.svg){#fig:encoder-decoder width=85%}

## From Encoder-Decoder to Decoder-Only

Most current LLMs — the GPT family and similar models — keep only the
decoder stack. There is no separate input sequence to encode: the model is
trained purely to predict the next token given everything that comes before
it, including its own prior output. Dropping the encoder collapses the
architecture from two stacks into one, and lets a single model train on any
text at all, not just paired source/target sequences — a large part of why
this variant is what scaled to today's LLMs.

## The Decoder-Only Stack, Visualized

![Drop the encoder and cross-attention, keep everything else: a decoder-only stack, repeated N times, trained purely as a next-token predictor over its own input. This is the shape used by most current LLMs.](figures/decoder-only.svg){#fig:decoder-only width=55%}

## Tokens and Embeddings

Before the first layer, every token id is looked up in an **embedding
table** and turned into a vector — a list of numbers that starts out
arbitrary and comes to encode something about the token's meaning as
training proceeds. From here on, everything the model does happens to these
vectors, one per token position, all the way through the stack.

## Positional Information

Unlike a recurrent network, a transformer processes all token positions in
parallel — nothing in the architecture itself tells it that token 3 comes
before token 4. **Positional information** is added (or learned) alongside
each token's embedding specifically to supply that order. Without it, "the
dog bit the man" and "the man bit the dog" would look identical to every
layer that follows.

## Self-Attention

**Self-attention** lets a token's representation absorb information from
every other token in the sequence, weighted by how relevant each one is.
Each token produces a *query*, and compares it against every other token's
*key* to decide how much of that token's *value* to mix in. Take "The cat
sat on the mat because it was tired": when the model processes *it*, its
query ends up matching *cat*'s key far more strongly than any other token's —
so *it*'s new representation becomes mostly a weighted mix of *cat*'s value.
That is the mechanism behind a fixed context window — every token a model can
condition on is a token self-attention can reach, and nothing further back.
In practice, a layer runs several of these attention mechanisms in parallel —
called **heads** — each free to focus on a different kind of relationship,
then combines their results.

## Self-Attention, Visualized

![Query/key/value weighting: the query token ("it") compares against every other token's key, and its new representation becomes a weighted mix of their values — here, dominated by "cat."](figures/self-attention.svg){#fig:self-attention width=95%}

## Feed-Forward, Residuals, and Normalization

After attention mixes information *across* tokens, a **feed-forward block**
transforms each token's representation independently — the same small
network applied at every position. Two things hold a deep stack of these
layers together: a **residual connection** adds each block's input back to
its output, so information and gradients have a direct path through the
whole stack; and **normalization** keeps the scale of the numbers flowing
through it stable, layer after layer. Without both, stacking more than a
handful of layers stops training reliably.

## Stacking Layers to a Next-Token Distribution

A decoder-only transformer is this block — attention, feed-forward,
residuals, normalization — repeated N times (GPT-2 small, used in the demo
below, stacks N=12 of them), each layer building a more abstract
representation of the sequence than the last. After the final layer, one
more projection maps each position's vector onto the size of the vocabulary
and turns it into a probability distribution over what token comes next —
not a single answer, but odds across the entire vocabulary. Sampling from
that distribution is what produces the next token.

## Demo: A Forward Pass, Layer by Layer

Run the same sentence through a real GPT-2 small (`demo/forward_pass.py`) and
watch the shape stay constant while the content changes:

```
Input: 'The cat sat on the mat because it was tired'
Tokens (10): The, cat, sat, on, the, mat, because, it, was, tired
  token + positional embedding : (1, 10, 768)
  after decoder layer  1        : (1, 10, 768)
  after decoder layer  2        : (1, 10, 768)
  ...
  after decoder layer 12        : (1, 10, 768)
  final projection to vocab     : (1, 10, 50257)
```

Every layer hands back a tensor of the same shape it took in.

## Demo: The Next Token, For Real

The one place the shape changes is the final projection, which turns each
position's vector into odds over all 50,257 possible next tokens:

```
Next-token distribution after 'tired' (top 5 of 50257):
   '.'     0.273
   ' and'  0.208
   ','     0.190
   ' of'   0.128
   ' from' 0.044
```

No single "answer" — a `(1, 10, 50257)` tensor of odds, and generation just
samples one.

## Demo: Attention, Visualized

![Real attention weights from GPT-2 small, layer 5 head 4, on the sentence "The cat sat on the mat because it was tired": the row for "it" lights up almost entirely on "cat" — query/key/value weighting, captured on an actual model instead of asserted.](figures/demo-attention-map.png){#fig:demo-attention width=70%}
