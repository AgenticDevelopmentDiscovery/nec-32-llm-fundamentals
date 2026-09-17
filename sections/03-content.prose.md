# Content

<!-- Every `##` becomes one slide. One idea each.
     This is the main portion of the tutorial and the section most likely to
     need more `##` units than shown below. Add them freely — each new
     heading is a new slide, and splitting is how you find the joints. -->

## The Original Transformer: Encoder-Decoder

The architecture introduced in "Attention Is All You Need" (Vaswani et al.,
2017) has two stacks: an **encoder**, which reads the entire input sequence
and builds a representation of it, and a **decoder**, which generates the
output sequence one token at a time, attending both to its own previous
outputs and to the encoder's representation. This shape was built for
sequence-to-sequence tasks like translation, where there is a clear source
sequence and a target sequence that are meaningfully different from one
another.

**Figure (TODO):** the encoder-decoder architecture, Vaswani et al. (2017),
Figure 1 — reused, attributed.

## From Encoder-Decoder to Decoder-Only

Most current LLMs — the GPT family and similar models — keep only the
decoder stack. There is no separate input sequence to encode: the model is
trained purely to predict the next token given everything that comes before
it, including its own prior output. Dropping the encoder collapses the
architecture from two stacks into one, and lets a single model train on any
text at all, not just paired source/target sequences — a large part of why
this variant is what scaled to today's LLMs.

**Figure (TODO):** the decoder-only architecture — the tutorial's anchor
visual, reused/annotated across the units below.

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
*key* to decide how much of that token's *value* to mix in. This is why a
pronoun's representation can shift to reflect a noun several sentences
earlier — and it is the mechanism the "context window" claims from the
motivation section are actually about: the window is the set of tokens
self-attention can reach.

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
residuals, normalization — repeated N times, each layer building a more
abstract representation of the sequence than the last. After the final
layer, one more projection maps each position's vector onto the size of the
vocabulary and turns it into a probability distribution: the "outputs a
distribution, not a single answer" claim from the first section is this
step. Sampling from that distribution is what produces the next token.

## Demo: A Forward Pass, Layer by Layer

**Demo (pending confirmation of approach):** load a small open-weights
decoder-only model, feed it a short input, and print the tensor shape — and,
where feasible, an attention-map snapshot — after each layer, so the
walkthrough above is something you watch happen on real data rather than
take on faith.
