"""Shared BDD fixtures and step definitions for integration tests."""

from __future__ import annotations

import pytest

from .constants import _World

# Import step packages — each __init__.py aggregates its step files.
# Wildcard into conftest namespace so pytest-bdd can discover step definitions.
from .given import *  # noqa: F401,F403
from .then import *  # noqa: F401,F403
from .when import *  # noqa: F401,F403


@pytest.fixture
def world() -> _World:
    """Per-scenario mutable state shared across all BDD steps."""
    return _World({"result": None, "error": None})
