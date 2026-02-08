"""Tests for the EventBridge pattern matching engine."""

from __future__ import annotations

from ldk.providers.eventbridge.pattern_matcher import match_event

# ===========================================================================
# Exact value matching
# ===========================================================================


# ===========================================================================
# Prefix matching
# ===========================================================================


# ===========================================================================
# Numeric range matching
# ===========================================================================


# ===========================================================================
# Exists / not-exists matching
# ===========================================================================


# ===========================================================================
# Anything-but matching
# ===========================================================================


# ===========================================================================
# Nested detail patterns
# ===========================================================================


# ===========================================================================
# Multiple keys in pattern
# ===========================================================================


# ===========================================================================
# Empty / None pattern
# ===========================================================================


class TestExistsMatching:
    """Test exists and not-exists matching in event patterns."""

    def test_exists_true_present(self) -> None:
        pattern = {"detail": {"status": [{"exists": True}]}}
        event = {"detail": {"status": "active"}}
        assert match_event(pattern, event) is True

    def test_exists_true_absent(self) -> None:
        pattern = {"detail": {"status": [{"exists": True}]}}
        event = {"detail": {"other": "value"}}
        assert match_event(pattern, event) is False

    def test_exists_false_absent(self) -> None:
        pattern = {"detail": {"status": [{"exists": False}]}}
        event = {"detail": {"other": "value"}}
        assert match_event(pattern, event) is True

    def test_exists_false_present(self) -> None:
        pattern = {"detail": {"status": [{"exists": False}]}}
        event = {"detail": {"status": "active"}}
        assert match_event(pattern, event) is False

    def test_exists_true_top_level(self) -> None:
        pattern = {"source": [{"exists": True}]}
        event = {"source": "aws.ec2"}
        assert match_event(pattern, event) is True

    def test_exists_true_top_level_absent(self) -> None:
        pattern = {"source": [{"exists": True}]}
        event = {"detail-type": "Something"}
        assert match_event(pattern, event) is False
