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


class TestExactValueMatching:
    """Test exact value matching in event patterns."""

    def test_exact_string_match(self) -> None:
        pattern = {"source": ["aws.ec2"]}
        event = {"source": "aws.ec2", "detail-type": "EC2 Instance State-change"}
        assert match_event(pattern, event) is True

    def test_exact_string_no_match(self) -> None:
        pattern = {"source": ["aws.s3"]}
        event = {"source": "aws.ec2"}
        assert match_event(pattern, event) is False

    def test_exact_multiple_values(self) -> None:
        pattern = {"source": ["aws.ec2", "aws.s3"]}
        event = {"source": "aws.s3"}
        assert match_event(pattern, event) is True

    def test_exact_multiple_values_no_match(self) -> None:
        pattern = {"source": ["aws.ec2", "aws.s3"]}
        event = {"source": "aws.lambda"}
        assert match_event(pattern, event) is False

    def test_exact_number_match(self) -> None:
        pattern = {"detail": {"count": [5]}}
        event = {"detail": {"count": 5}}
        assert match_event(pattern, event) is True

    def test_exact_number_no_match(self) -> None:
        pattern = {"detail": {"count": [5]}}
        event = {"detail": {"count": 10}}
        assert match_event(pattern, event) is False

    def test_exact_boolean_match(self) -> None:
        pattern = {"detail": {"enabled": [True]}}
        event = {"detail": {"enabled": True}}
        assert match_event(pattern, event) is True

    def test_missing_key_no_match(self) -> None:
        pattern = {"source": ["aws.ec2"]}
        event = {"detail-type": "Something"}
        assert match_event(pattern, event) is False
