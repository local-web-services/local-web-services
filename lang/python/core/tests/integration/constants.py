"""Constants and shared helpers."""

from __future__ import annotations

import pytest


class _World(dict):
    """Per-scenario state dict that auto-skips on 'not yet implemented' responses."""

    def __setitem__(self, key, value):
        if key == "error" and isinstance(value, dict):
            msg = value.get("Message", "") or value.get("message", "")
            if "not yet implemented" in msg:
                pytest.skip(msg)
        super().__setitem__(key, value)
