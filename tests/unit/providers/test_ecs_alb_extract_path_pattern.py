"""Tests for ldk.providers.ecs.alb."""

from __future__ import annotations

from lws.providers.ecs.alb import (
    _extract_path_pattern,
)

# ---------------------------------------------------------------------------
# Path matching tests
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# Rule matching tests
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# Listener rule parsing tests
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# _extract_path_pattern tests
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# ALB FastAPI app tests
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# ListenerRule tests
# ---------------------------------------------------------------------------


class TestExtractPathPattern:
    def test_field_based(self) -> None:
        conditions = [{"Field": "path-pattern", "Values": ["/api/*"]}]
        assert _extract_path_pattern(conditions) == "/api/*"

    def test_config_based(self) -> None:
        conditions = [{"PathPatternConfig": {"Values": ["/web/*"]}}]
        assert _extract_path_pattern(conditions) == "/web/*"

    def test_empty_conditions(self) -> None:
        assert _extract_path_pattern([]) is None

    def test_no_matching_field(self) -> None:
        conditions = [{"Field": "host-header", "Values": ["example.com"]}]
        assert _extract_path_pattern(conditions) is None
