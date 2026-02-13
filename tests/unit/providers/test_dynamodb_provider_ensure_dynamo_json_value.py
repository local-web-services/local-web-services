"""Tests for _ensure_dynamo_json_value single-value helper."""

from __future__ import annotations

from lws.providers.dynamodb.provider import (
    _ensure_dynamo_json_value,
)


class TestEnsureDynamoJsonValue:
    """_ensure_dynamo_json_value wraps plain values and preserves typed ones."""

    def test_plain_string_wrapped(self) -> None:
        # Arrange
        expected_value = {"S": "hello"}

        # Act
        actual_value = _ensure_dynamo_json_value("hello")

        # Assert
        assert actual_value == expected_value

    def test_plain_int_wrapped(self) -> None:
        # Arrange
        expected_value = {"N": "42"}

        # Act
        actual_value = _ensure_dynamo_json_value(42)

        # Assert
        assert actual_value == expected_value

    def test_plain_bool_wrapped(self) -> None:
        # Arrange
        expected_value = {"BOOL": True}

        # Act
        actual_value = _ensure_dynamo_json_value(True)

        # Assert
        assert actual_value == expected_value

    def test_plain_none_wrapped(self) -> None:
        # Arrange
        expected_value = {"NULL": True}

        # Act
        actual_value = _ensure_dynamo_json_value(None)

        # Assert
        assert actual_value == expected_value

    def test_typed_string_preserved(self) -> None:
        # Arrange
        typed_value = {"S": "hello"}

        # Act
        actual_value = _ensure_dynamo_json_value(typed_value)

        # Assert
        assert actual_value == typed_value

    def test_typed_number_preserved(self) -> None:
        # Arrange
        typed_value = {"N": "42"}

        # Act
        actual_value = _ensure_dynamo_json_value(typed_value)

        # Assert
        assert actual_value == typed_value

    def test_typed_bool_preserved(self) -> None:
        # Arrange
        typed_value = {"BOOL": False}

        # Act
        actual_value = _ensure_dynamo_json_value(typed_value)

        # Assert
        assert actual_value == typed_value

    def test_typed_list_preserved(self) -> None:
        # Arrange
        typed_value = {"L": [{"S": "a"}, {"N": "1"}]}

        # Act
        actual_value = _ensure_dynamo_json_value(typed_value)

        # Assert
        assert actual_value == typed_value

    def test_typed_map_preserved(self) -> None:
        # Arrange
        typed_value = {"M": {"name": {"S": "Alice"}}}

        # Act
        actual_value = _ensure_dynamo_json_value(typed_value)

        # Assert
        assert actual_value == typed_value
