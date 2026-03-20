"""Unit tests for parse_operation_file with multiple operations."""

from __future__ import annotations

from pathlib import Path

from lws.providers._shared.aws_fake_dsl import parse_operation_file


class TestParseOperationFileMultiple:
    def test_multiple_operations_in_one_file(self, tmp_path: Path):
        # Arrange
        expected_first_operation = "get-item"
        expected_second_operation = "put-item"
        expected_first_status = 200
        expected_second_status = 201
        service = "dynamodb"
        op_file = tmp_path / "multiple.yaml"
        op_file.write_text(
            "operations:\n"
            "  - operation: get-item\n"
            "    response:\n"
            "      status: 200\n"
            "      body: found\n"
            "  - operation: put-item\n"
            "    response:\n"
            "      status: 201\n"
            "      body: created\n"
        )

        # Act
        rules = parse_operation_file(op_file, service, tmp_path)

        # Assert
        assert len(rules) == 2, f"Expected {2!r} but got {len(rules)!r}"
        actual_first_operation = rules[0].operation
        actual_second_operation = rules[1].operation
        actual_first_status = rules[0].response.status
        actual_second_status = rules[1].response.status
        assert actual_first_operation == expected_first_operation, (
            f"Expected {expected_first_operation!r} but got {actual_first_operation!r}"
        )
        assert actual_second_operation == expected_second_operation, (
            f"Expected {expected_second_operation!r} but got {actual_second_operation!r}"
        )
        assert actual_first_status == expected_first_status, (
            f"Expected {expected_first_status!r} but got {actual_first_status!r}"
        )
        assert actual_second_status == expected_second_status, (
            f"Expected {expected_second_status!r} but got {actual_second_status!r}"
        )
