"""Tests for ldk.providers.ecs.alb."""

from __future__ import annotations

from lws.providers.ecs.alb import (
    ListenerRule,
    _find_matching_rule,
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


class TestFindMatchingRule:
    def test_returns_highest_priority_match(self) -> None:
        rules = [
            ListenerRule(priority=200, path_pattern="/api/*", target_port=8080),
            ListenerRule(priority=100, path_pattern="/api/*", target_port=9090),
        ]
        result = _find_matching_rule(rules, "/api/users")
        assert result is not None
        assert result.target_port == 9090

    def test_returns_none_when_no_match(self) -> None:
        rules = [ListenerRule(priority=1, path_pattern="/api/*", target_port=8080)]
        result = _find_matching_rule(rules, "/other")
        assert result is None

    def test_empty_rules_returns_none(self) -> None:
        assert _find_matching_rule([], "/path") is None
