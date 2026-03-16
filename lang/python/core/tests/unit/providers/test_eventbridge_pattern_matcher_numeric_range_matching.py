"""Tests for the EventBridge pattern matching engine."""

from __future__ import annotations

from lws.providers.eventbridge.pattern_matcher import match_event

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


class TestNumericRangeMatching:
    """Test numeric range matching in event patterns."""

    def test_greater_than(self) -> None:
        pattern = {"detail": {"price": [{"numeric": [">", 100]}]}}
        event = {"detail": {"price": 150}}
        assert match_event(pattern, event) is True

    def test_greater_than_fails(self) -> None:
        pattern = {"detail": {"price": [{"numeric": [">", 100]}]}}
        event = {"detail": {"price": 50}}
        assert match_event(pattern, event) is False

    def test_greater_than_or_equal(self) -> None:
        pattern = {"detail": {"price": [{"numeric": [">=", 100]}]}}
        event = {"detail": {"price": 100}}
        assert match_event(pattern, event) is True

    def test_less_than(self) -> None:
        pattern = {"detail": {"price": [{"numeric": ["<", 100]}]}}
        event = {"detail": {"price": 50}}
        assert match_event(pattern, event) is True

    def test_less_than_or_equal(self) -> None:
        pattern = {"detail": {"price": [{"numeric": ["<=", 100]}]}}
        event = {"detail": {"price": 100}}
        assert match_event(pattern, event) is True

    def test_equality(self) -> None:
        pattern = {"detail": {"price": [{"numeric": ["=", 42]}]}}
        event = {"detail": {"price": 42}}
        assert match_event(pattern, event) is True

    def test_range(self) -> None:
        pattern = {"detail": {"price": [{"numeric": [">=", 100, "<", 200]}]}}
        event = {"detail": {"price": 150}}
        assert match_event(pattern, event) is True

    def test_range_out_of_bounds(self) -> None:
        pattern = {"detail": {"price": [{"numeric": [">=", 100, "<", 200]}]}}
        event = {"detail": {"price": 250}}
        assert match_event(pattern, event) is False

    def test_numeric_non_number_value(self) -> None:
        pattern = {"detail": {"price": [{"numeric": [">", 100]}]}}
        event = {"detail": {"price": "not-a-number"}}
        assert match_event(pattern, event) is False

    def test_numeric_missing_value(self) -> None:
        pattern = {"detail": {"price": [{"numeric": [">", 100]}]}}
        event = {"detail": {}}
        assert match_event(pattern, event) is False
