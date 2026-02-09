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


class TestAnythingButMatching:
    """Test anything-but matching in event patterns."""

    def test_anything_but_excludes_value(self) -> None:
        pattern = {"source": [{"anything-but": ["aws.ec2"]}]}
        event = {"source": "aws.ec2"}
        assert match_event(pattern, event) is False

    def test_anything_but_passes_different_value(self) -> None:
        pattern = {"source": [{"anything-but": ["aws.ec2"]}]}
        event = {"source": "aws.s3"}
        assert match_event(pattern, event) is True

    def test_anything_but_multiple_exclusions(self) -> None:
        pattern = {"source": [{"anything-but": ["aws.ec2", "aws.s3"]}]}
        event = {"source": "aws.s3"}
        assert match_event(pattern, event) is False

    def test_anything_but_single_string(self) -> None:
        pattern = {"source": [{"anything-but": "aws.ec2"}]}
        event = {"source": "aws.s3"}
        assert match_event(pattern, event) is True

    def test_anything_but_single_string_match(self) -> None:
        pattern = {"source": [{"anything-but": "aws.ec2"}]}
        event = {"source": "aws.ec2"}
        assert match_event(pattern, event) is False

    def test_anything_but_missing_value(self) -> None:
        pattern = {"source": [{"anything-but": ["aws.ec2"]}]}
        event = {"detail": "something"}
        assert match_event(pattern, event) is False
