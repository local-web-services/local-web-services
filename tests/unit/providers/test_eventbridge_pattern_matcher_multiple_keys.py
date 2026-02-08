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


class TestMultipleKeys:
    """Test patterns with multiple keys (AND logic)."""

    def test_all_keys_must_match(self) -> None:
        pattern = {
            "source": ["aws.ec2"],
            "detail-type": ["EC2 Instance State-change Notification"],
        }
        event = {
            "source": "aws.ec2",
            "detail-type": "EC2 Instance State-change Notification",
        }
        assert match_event(pattern, event) is True

    def test_partial_match_fails(self) -> None:
        pattern = {
            "source": ["aws.ec2"],
            "detail-type": ["EC2 Instance State-change Notification"],
        }
        event = {
            "source": "aws.ec2",
            "detail-type": "Something Else",
        }
        assert match_event(pattern, event) is False
