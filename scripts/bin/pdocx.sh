#!/bin/bash

pandoc \
  --from=markdown --to=docx \
  --output="$HOME/Desktop/out.docx" \
  "${*}"

