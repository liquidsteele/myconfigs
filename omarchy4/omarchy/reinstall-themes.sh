#!/bin/bash
# Reinstala os temas listados em themes.tsv via omarchy.
set -euo pipefail
cd "$(dirname "$0")"
while IFS=$'\t' read -r name url; do
  [[ -z ${name:-} || $name == \#* ]] && continue
  echo "==> $name"
  omarchy theme install "$url" || echo "  falhou: $name ($url)"
done < themes.tsv
