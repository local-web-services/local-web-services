"""Tests for ldk.providers.ecs.alb."""

from __future__ import annotations

from lws.providers.ecs.alb import (
    _path_matches,
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


class TestPathMatches:
    def test_wildcard_matches_everything(self) -> None:
        assert _path_matches("*", "/anything") is True

    def test_slash_wildcard_matches_everything(self) -> None:
        assert _path_matches("/*", "/anything") is True

    def test_prefix_wildcard(self) -> None:
        assert _path_matches("/api/*", "/api/users") is True
        assert _path_matches("/api/*", "/other/path") is False

    def test_suffix_wildcard(self) -> None:
        assert _path_matches("*.html", "/page.html") is True
        assert _path_matches("*.html", "/page.json") is False

    def test_exact_match(self) -> None:
        assert _path_matches("/health", "/health") is True
        assert _path_matches("/health", "/healthz") is False
