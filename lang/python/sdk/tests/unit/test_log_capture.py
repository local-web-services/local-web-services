"""Unit tests: LogCapture filtering and assertion methods."""

from __future__ import annotations

from lws_testing._logs import LogCapture


def _make_capture(entries: list) -> LogCapture:
    """Return a LogCapture pre-loaded with the given entries."""
    capture = LogCapture(None)
    capture._entries = entries
    return capture


def test_for_service_returns_only_matching_entries():
    # Arrange
    entries = [
        {"service": "dynamodb", "operation": "PutItem"},
        {"service": "sqs", "operation": "SendMessage"},
        {"service": "dynamodb", "operation": "GetItem"},
    ]
    capture = _make_capture(entries)
    expected_count = 2

    # Act
    actual_entries = capture.for_service("dynamodb")

    # Assert
    assert len(actual_entries) == expected_count, (
        f"Expected {expected_count!r} but got {len(actual_entries)!r}"
    )


def test_for_service_is_case_insensitive():
    # Arrange
    entries = [
        {"service": "DynamoDB", "operation": "PutItem"},
    ]
    capture = _make_capture(entries)
    expected_count = 1

    # Act
    actual_entries = capture.for_service("dynamodb")

    # Assert
    assert len(actual_entries) == expected_count, (
        f"Expected {expected_count!r} but got {len(actual_entries)!r}"
    )


def test_for_service_returns_empty_list_when_no_match():
    # Arrange
    entries = [
        {"service": "sqs", "operation": "SendMessage"},
    ]
    capture = _make_capture(entries)
    expected_entries: list = []

    # Act
    actual_entries = capture.for_service("dynamodb")

    # Assert
    assert actual_entries == expected_entries, (
        f"Expected {expected_entries!r} but got {actual_entries!r}"
    )


def test_for_operation_returns_only_matching_entries():
    # Arrange
    entries = [
        {"service": "dynamodb", "operation": "PutItem"},
        {"service": "dynamodb", "operation": "GetItem"},
        {"service": "sqs", "operation": "PutItem"},
    ]
    capture = _make_capture(entries)
    expected_count = 2

    # Act
    actual_entries = capture.for_operation("PutItem")

    # Assert
    assert len(actual_entries) == expected_count, (
        f"Expected {expected_count!r} but got {len(actual_entries)!r}"
    )


def test_for_operation_returns_empty_list_when_no_match():
    # Arrange
    entries = [
        {"service": "dynamodb", "operation": "PutItem"},
    ]
    capture = _make_capture(entries)
    expected_entries: list = []

    # Act
    actual_entries = capture.for_operation("DeleteItem")

    # Assert
    assert actual_entries == expected_entries, (
        f"Expected {expected_entries!r} but got {actual_entries!r}"
    )


def test_assert_call_count_passes_when_count_matches():
    # Arrange
    entries = [
        {"service": "dynamodb", "operation": "PutItem"},
        {"service": "dynamodb", "operation": "PutItem"},
        {"service": "sqs", "operation": "SendMessage"},
    ]
    capture = _make_capture(entries)
    expected_count = 2

    # Act
    raised = False
    try:
        capture.assert_call_count("dynamodb", "PutItem", expected_count)
    except AssertionError:
        raised = True

    # Assert
    assert not raised, "Expected value to be falsy"


def test_assert_call_count_fails_when_count_does_not_match():
    # Arrange
    entries = [
        {"service": "dynamodb", "operation": "PutItem"},
    ]
    capture = _make_capture(entries)
    expected_count = 3

    # Act
    raised = False
    try:
        capture.assert_call_count("dynamodb", "PutItem", expected_count)
    except AssertionError:
        raised = True

    # Assert
    assert raised, "Expected value to be truthy"


def test_assert_call_count_zero_passes_when_not_called():
    # Arrange
    entries = [
        {"service": "sqs", "operation": "SendMessage"},
    ]
    capture = _make_capture(entries)
    expected_count = 0

    # Act
    raised = False
    try:
        capture.assert_call_count("dynamodb", "PutItem", expected_count)
    except AssertionError:
        raised = True

    # Assert
    assert not raised, "Expected value to be falsy"
