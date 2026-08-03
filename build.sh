#!/usr/bin/env bash
# Build ai-error-framework.pdf into ./build
set -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"
cd "$ROOT"

DOC="ai-error-framework"
OUTDIR="build"
PDF="${OUTDIR}/${DOC}.pdf"

usage() {
  cat <<EOF
Usage: $(basename "$0") [build|force|clean|help]

  build   Compile if sources changed → ${PDF} (default)
  force   Rebuild unconditionally
  clean   Remove ${OUTDIR}/
  help    Show this message
EOF
}

clean() {
  rm -rf "$OUTDIR"
  echo "Removed ${OUTDIR}/"
}

build() {
  local force="${1:-0}"

  if [[ ! -f "${DOC}.tex" ]]; then
    echo "error: ${DOC}.tex not found in ${ROOT}" >&2
    exit 1
  fi

  mkdir -p "$OUTDIR"

  local before=""
  [[ -f "$PDF" ]] && before="$(stat -f '%m' "$PDF" 2>/dev/null || stat -c '%Y' "$PDF")"

  if command -v latexmk >/dev/null 2>&1; then
    local args=(-pdf -interaction=nonstopmode -output-directory="$OUTDIR")
    if [[ "$force" == "1" ]]; then
      args+=(-g)
    fi
    latexmk "${args[@]}" "${DOC}.tex"
  else
    pdflatex -interaction=nonstopmode -output-directory="$OUTDIR" "${DOC}.tex"
    pdflatex -interaction=nonstopmode -output-directory="$OUTDIR" "${DOC}.tex"
  fi

  local after=""
  [[ -f "$PDF" ]] && after="$(stat -f '%m' "$PDF" 2>/dev/null || stat -c '%Y' "$PDF")"

  if [[ -n "$before" && "$before" == "$after" && "$force" != "1" ]]; then
    echo "Up to date: ${PDF}"
  else
    echo "Built ${PDF}"
  fi
}

case "${1:-build}" in
  build) build 0 ;;
  force) build 1 ;;
  clean) clean ;;
  help|-h|--help) usage ;;
  *)
    echo "error: unknown command '${1}'" >&2
    usage >&2
    exit 1
    ;;
esac
