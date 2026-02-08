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


class TestPrefixMatching:
    """Test prefix matching in event patterns."""

    def test_prefix_match(self) -> None:
        pattern = {"source": [{"prefix": "aws."}]}
        event = {"source": "aws.ec2"}
        assert match_event(pattern, event) is True

    def test_prefix_no_match(self) -> None:
        pattern = {"source": [{"prefix": "aws."}]}
        event = {"source": "custom.myapp"}
        assert match_event(pattern, event) is False

    def test_prefix_empty_string(self) -> None:
        pattern = {"source": [{"prefix": ""}]}
        event = {"source": "anything"}
        assert match_event(pattern, event) is True

    def test_prefix_non_string_value(self) -> None:
        pattern = {"detail": {"count": [{"prefix": "abc"}]}}
        event = {"detail": {"count": 123}}
        assert match_event(pattern, event) is False

    def test_prefix_with_exact_combined(self) -> None:
        pattern = {"source": [{"prefix": "aws."}, "custom.exact"]}
        event = {"source": "custom.exact"}
        assert match_event(pattern, event) is True

    def test_prefix_with_exact_combined_prefix_match(self) -> None:
        pattern = {"source": [{"prefix": "aws."}, "custom.exact"]}
        event = {"source": "aws.s3"}
        assert match_event(pattern, event) is True
