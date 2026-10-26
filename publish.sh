#!/usr/bin/env bash
set -euo pipefail
export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"

cd "$(dirname "$0")"
MSG="${1:-Update DeepMind Polaris portfolio and resume}"

git add -A
if git diff --cached --quiet; then
  echo "No new changes to commit."
else
  git commit -m "$MSG"
  git push origin main
  echo "Pushed to GitHub Pages: https://printerpilot.github.io/polaris-portfolio/"
fi
