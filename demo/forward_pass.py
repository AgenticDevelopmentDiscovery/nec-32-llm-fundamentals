"""Layer-by-layer forward pass demo for sections/03-content.prose.md.

Loads GPT-2 small (decoder-only, 12 layers), runs one short input through it,
prints the tensor shape after each layer, and saves an attention-head heatmap
for one layer so the reader watches the architecture walkthrough happen on
real data instead of taking it on faith.

Setup (once):
  python3 -m venv demo/.venv
  demo/.venv/bin/pip install torch --index-url https://download.pytorch.org/whl/cpu
  demo/.venv/bin/pip install transformers numpy matplotlib

Run:
  demo/.venv/bin/python demo/forward_pass.py
"""

import torch
from transformers import GPT2LMHeadModel, GPT2Tokenizer
import matplotlib.pyplot as plt

MODEL_NAME = "gpt2"  # GPT-2 small: 12 layers, 12 heads, d_model=768
INPUT_TEXT = "The cat sat on the mat because it was tired"

def main():
    tokenizer = GPT2Tokenizer.from_pretrained(MODEL_NAME)
    model = GPT2LMHeadModel.from_pretrained(MODEL_NAME, attn_implementation="eager")
    model.eval()

    inputs = tokenizer(INPUT_TEXT, return_tensors="pt")
    tokens = tokenizer.convert_ids_to_tokens(inputs["input_ids"][0])
    n_tokens = inputs["input_ids"].shape[1]

    print(f"Model: {MODEL_NAME}  ({model.config.n_layer} layers, "
          f"{model.config.n_head} heads, d_model={model.config.n_embd})")
    print(f"Input: {INPUT_TEXT!r}")
    print(f"Tokens ({n_tokens}): {tokens}")
    print()

    with torch.no_grad():
        out = model(**inputs, output_hidden_states=True, output_attentions=True)

    print("Shape after each stage:")
    print(f"  token + positional embedding : {tuple(out.hidden_states[0].shape)}"
          f"  (batch, tokens, d_model)")
    for i, hs in enumerate(out.hidden_states[1:], start=1):
        print(f"  after decoder layer {i:2d}          : {tuple(hs.shape)}")

    logits = out.logits
    print(f"  final projection to vocab    : {tuple(logits.shape)}"
          f"  (batch, tokens, vocab_size={model.config.vocab_size})")
    print()

    next_token_logits = logits[0, -1]
    probs = torch.softmax(next_token_logits, dim=-1)
    top5 = torch.topk(probs, 5)
    print(f"Next-token distribution after {tokens[-1]!r} (top 5 of "
          f"{model.config.vocab_size}):")
    for p, idx in zip(top5.values, top5.indices):
        print(f"  {tokenizer.decode([idx])!r:>12}  {p.item():.3f}")
    print()

    # Attention-map snapshot: layer 5, head 4 (0-indexed) is the head where
    # "it" attends most strongly to "cat" (weight 0.84) for this input --
    # the exact pronoun-resolution example already used in the prose.
    layer, head = 4, 3
    attn = out.attentions[layer][0, head].numpy()  # (tokens, tokens)

    fig, ax = plt.subplots(figsize=(6, 5))
    im = ax.imshow(attn, cmap="viridis")
    ax.set_xticks(range(n_tokens))
    ax.set_yticks(range(n_tokens))
    ax.set_xticklabels(tokens, rotation=90)
    ax.set_yticklabels(tokens)
    ax.set_xlabel("attending to (key)")
    ax.set_ylabel("query token")
    ax.set_title(f"GPT-2 small — layer {layer + 1}, head {head + 1} self-attention")
    fig.colorbar(im, ax=ax, label="attention weight")
    fig.tight_layout()
    fig.savefig("figures/demo-attention-map.png", dpi=150)
    print(f"Saved attention-map snapshot to figures/demo-attention-map.png "
          f"(layer {layer + 1}, head {head + 1})")

if __name__ == "__main__":
    main()
