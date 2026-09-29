#!/usr/bin/env bash
set -e

# Bioconda Docs live development server launcher
# Usage:
#   pixi run dev                  # Default: 10 recipes
#   pixi run dev 25               # Limit to 25 recipes
#   pixi run dev all              # Include all recipes (no filter)
#   pixi run dev 20 --port 8080   # Pass custom flags to sphinx-autobuild
#   BIOCONDA_FILTER_RECIPES=50 pixi run dev
#   BIOCONDA_FILTER_RECIPES="samtools" pixi run dev

FILTER="${BIOCONDA_FILTER_RECIPES:-10}"
EXTRA_ARGS=()

if [ $# -gt 0 ]; then
    if [[ "$1" =~ ^[0-9]+$ ]]; then
        FILTER="$1"
        shift
    elif [ "$1" = "all" ]; then
        FILTER=""
        shift
    fi
fi

EXTRA_ARGS+=("$@")

if [ -n "$FILTER" ]; then
    export BIOCONDA_FILTER_RECIPES="$FILTER"
    echo "==> Starting dev server with BIOCONDA_FILTER_RECIPES=$BIOCONDA_FILTER_RECIPES"
else
    unset BIOCONDA_FILTER_RECIPES
    echo "==> Starting dev server with all recipes (no filter)"
fi

exec sphinx-autobuild source build/html --re-ignore "/recipes/" "${EXTRA_ARGS[@]}"
