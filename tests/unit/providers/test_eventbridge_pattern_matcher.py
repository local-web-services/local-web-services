"""Tests for the EventBridge pattern matching engine."""

from __future__ import annotations

from ldk.providers.eventbridge.pattern_matcher import match_event

# ===========================================================================
# Exact value matching
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


# ===========================================================================
# Prefix matching
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


# ===========================================================================
# Numeric range matching
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


# ===========================================================================
# Exists / not-exists matching
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


# ===========================================================================
# Anything-but matching
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


# ===========================================================================
# Nested detail patterns
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


# ===========================================================================
# Multiple keys in pattern
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


# ===========================================================================
# Empty / None pattern
# ===========================================================================


class TestEmptyPattern:
    """Test that empty or None patterns match everything."""

    def test_empty_pattern_matches_all(self) -> None:
        assert match_event({}, {"source": "anything"}) is True

    def test_none_like_empty_pattern(self) -> None:
        # Empty dict treated as match-all
        assert match_event({}, {}) is True
