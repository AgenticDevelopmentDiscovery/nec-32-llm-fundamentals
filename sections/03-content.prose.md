# Content

## The Original Transformer: Encoder-Decoder

As introduced earlier, the Transformer replaced recurrence with attention to
solve machine translation — here is the shape that gave it that capability.
The architecture from "Attention Is All You Need" (Vaswani et al., 2017) has
two stacks: an **encoder**, which reads the entire input sequence and builds
a representation of it, and a **decoder**, which generates the output
sequence one token at a time. The decoder attends to two things at once: its
own previous outputs, and the encoder's representation of the input, through
a mechanism called **cross-attention**. This shape fit translation
naturally — a clear source sequence and a target sequence that are
meaningfully different from one another.

![The original Transformer's two stacks: an encoder that reads the whole input, and a decoder that generates output tokens one at a time, attending to its own prior output and — via cross-attention — to the encoder's representation. Adapted from Vaswani et al. (2017), Figure 1.](figures/encoder-decoder.svg){#fig:encoder-decoder width=80%}

## From Encoder-Decoder to Decoder-Only

Most current LLMs — the GPT family and similar models — keep only the
decoder stack, and drop cross-attention along with the encoder it attended
to. There is no separate input sequence to encode: the model is trained
purely to predict the next token given everything that comes before it,
including its own prior output. Dropping the encoder collapses the
architecture from two stacks into one, and lets a single model train on any
text at all, not just paired source/target sequences — a large part of why
this variant is what scaled to today's LLMs.

![Drop the encoder and cross-attention, keep everything else: a decoder-only stack, repeated N times, trained purely as a next-token predictor over its own input. This is the shape used by most current LLMs, adapted from the encoder-decoder architecture above.](figures/decoder-only.svg){#fig:decoder-only width=50%}

## Tokens and Embeddings

Before the first layer, every token id is looked up in an **embedding
table** and turned into a vector — a list of numbers that starts out
arbitrary and comes to encode something about the token's meaning as
training proceeds. From here on, everything the model does happens to these
vectors, one per token position, all the way through the stack shown in
Figure 2.

## Positional Information

Unlike a recurrent network, a transformer processes all token positions in
parallel — nothing in the architecture itself tells it that token 3 comes
before token 4. **Positional information** is added (or learned) alongside
each token's embedding specifically to supply that order. Without it, "the
dog bit the man" and "the man bit the dog" would look identical to every
layer that follows.

## Self-Attention

**Self-attention** — the first block inside each layer of Figure 2 — lets a
token's representation absorb information from every other token in the
sequence, weighted by how relevant each one is. Each token produces a
*query*, and compares it against every other token's *key* to decide how
much of that token's *value* to mix in. Take "The cat sat on the mat because
it was tired": when the model processes *it*, its query ends up matching
*cat*'s key far more strongly than any other token's — so *it*'s new
representation becomes mostly a weighted mix of *cat*'s value. That is the
mechanism behind a fixed context window — every token a model can condition
on is a token self-attention can reach, and nothing further back. In
practice, a layer runs several of these attention mechanisms in parallel —
called **heads** — each free to focus on a different kind of relationship,
then combines their results.

![Query/key/value weighting on the example sentence above: the query token ("it") compares against every other token's key, and its new representation becomes a weighted mix of their values — dominated here by "cat." Illustrates the mechanism described in Vaswani et al. (2017), §3.2.](figures/self-attention.svg){#fig:self-attention width=90%}

## Feed-Forward, Residuals, and Normalization

After self-attention mixes information *across* tokens, a **feed-forward
block** — the second piece of each layer in Figure 2 — transforms each
token's representation independently: the same small network applied at
every position. Two things hold a deep stack of these layers together, and
Figure 4 draws both: a **residual connection** adds each block's input back
to its output, so information has a direct path through the whole stack,
bypassing self-attention and feed-forward in turn; and **normalization**
keeps the scale of the numbers flowing through it stable, layer after layer.
Without both, stacking more than a handful of layers stops being workable at
all — it's what makes a stack twelve or a hundred layers deep something you
can actually build, rather than something that only works on paper.

![One full decoder block: self-attention and feed-forward, each followed by a residual connection (green) and normalization — the unit that Figure 2's "×N" repeats.](figures/residuals.svg){#fig:residuals width=52%}

## Stacking Layers to a Next-Token Distribution

A decoder-only transformer is this block — pictured whole in Figure 4 —
repeated N times (GPT-2 small, used in the demo below, stacks N=12 of them),
each layer building a more abstract representation of the sequence than the
last. After the final layer, one more projection maps each position's vector
onto the size of the vocabulary and turns it into a probability distribution
over what token comes next — not a single answer, but odds across the entire
vocabulary. Sampling from that distribution is what produces the next token.

## Demo: A Forward Pass, Layer by Layer

Run the same sentence through a real GPT-2 small (`demo/forward_pass.py` —
setup: `pip install torch transformers matplotlib`, then `python
demo/forward_pass.py`) and watch the shape stay constant while the content
changes:

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

Every layer hands back a tensor of the same shape it took in — the one place
the shape changes is the final projection, which turns each position's
vector into odds over all 50,257 possible next tokens:

```
Next-token distribution after 'tired' (top 5 of 50257):
   '.'     0.273
   ' and'  0.208
   ','     0.190
   ' of'   0.128
   ' from' 0.044
```

No single "answer" — a `(1, 10, 50257)` tensor of odds, and generation just
samples one. The self-attention weights are just as inspectable as the
output: Figure 5 captures layer 5, head 4 of this same run, the head where
"it" attends most strongly to "cat" — the same query/key/value mechanism
from Figure 3, captured on an actual model instead of asserted.

![Real attention weights from GPT-2 small, layer 5 head 4, on the sentence "The cat sat on the mat because it was tired": the row for "it" lights up almost entirely on "cat."](figures/demo-attention-map.png){#fig:demo-attention width=65%}
