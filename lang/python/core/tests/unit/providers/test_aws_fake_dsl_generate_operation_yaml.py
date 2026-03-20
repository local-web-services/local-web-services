"""Unit tests for generate_operation_yaml."""

from __future__ import annotations

from lws.providers._shared.aws_fake_dsl import generate_operation_yaml


class TestGenerateOperationYaml:
    def test_contains_operation_and_status(self):
        # Arrange
        expected_operation_fragment = "operation: get-object"
        expected_status_fragment = "status: 200"

        # Act
        actual_yaml = generate_operation_yaml("get-object", status=200, body="hello")

        # Assert
        assert expected_operation_fragment in actual_yaml, (
            f"Expected {expected_operation_fragment!r} to be in {actual_yaml!r}"
        )
        assert expected_status_fragment in actual_yaml, (
            f"Expected {expected_status_fragment!r} to be in {actual_yaml!r}"
        )

    def test_contains_body(self):
        # Arrange
        expected_body_fragment = "body: hello"

        # Act
        actual_yaml = generate_operation_yaml("get-object", status=200, body="hello")

        # Assert
        assert expected_body_fragment in actual_yaml, (
            f"Expected {expected_body_fragment!r} to be in {actual_yaml!r}"
        )

    def test_without_body(self):
        # Arrange
        expected_operation_fragment = "operation: delete-object"
        expected_status_fragment = "status: 204"

        # Act
        actual_yaml = generate_operation_yaml("delete-object", status=204)

        # Assert
        assert expected_operation_fragment in actual_yaml, (
            f"Expected {expected_operation_fragment!r} to be in {actual_yaml!r}"
        )
        assert expected_status_fragment in actual_yaml, (
            f"Expected {expected_status_fragment!r} to be in {actual_yaml!r}"
        )
        assert "body:" not in actual_yaml, f'Expected {"body:"!r} to not be in {actual_yaml!r}'
