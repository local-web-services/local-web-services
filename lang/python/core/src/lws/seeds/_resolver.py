"""Seed name resolution for Organizations provider."""

from __future__ import annotations

import os

_BUILTIN_SEEDS = {
    "enterprise": os.path.join(os.path.dirname(__file__), "enterprise.yaml"),
}


def resolve_seed_path(seed: str) -> str:
    """Resolve a seed name or file path to an absolute path.

    If *seed* matches a built-in seed name, return the path to that built-in file.
    Otherwise treat *seed* as a file path and return it as-is.
    """
    if seed in _BUILTIN_SEEDS:
        return _BUILTIN_SEEDS[seed]
    return seed
