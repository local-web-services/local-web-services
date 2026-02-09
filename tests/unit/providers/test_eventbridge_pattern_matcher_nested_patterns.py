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


class TestNestedPatterns:
    """Test nested detail pattern matching."""

    def test_nested_detail_match(self) -> None:
        pattern = {
            "source": ["aws.ec2"],
            "detail": {
                "state": ["running"],
            },
        }
        event = {
            "source": "aws.ec2",
            "detail": {"state": "running", "instance-id": "i-12345"},
        }
        assert match_event(pattern, event) is True

    def test_nested_detail_no_match(self) -> None:
        pattern = {
            "source": ["aws.ec2"],
            "detail": {
                "state": ["stopped"],
            },
        }
        event = {
            "source": "aws.ec2",
            "detail": {"state": "running"},
        }
        assert match_event(pattern, event) is False

    def test_deeply_nested_match(self) -> None:
        pattern = {
            "detail": {
                "bucket": {
                    "name": ["my-bucket"],
                },
            },
        }
        event = {
            "detail": {
                "bucket": {"name": "my-bucket", "arn": "arn:..."},
            },
        }
        assert match_event(pattern, event) is True

    def test_nested_non_dict_event_value(self) -> None:
        pattern = {"detail": {"nested": {"key": ["val"]}}}
        event = {"detail": {"nested": "not-a-dict"}}
        assert match_event(pattern, event) is False
