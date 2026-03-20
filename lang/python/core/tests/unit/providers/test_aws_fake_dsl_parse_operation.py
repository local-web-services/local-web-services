"""Unit tests for parse_operation_file simple case."""

from __future__ import annotations

from pathlib import Path

from lws.providers._shared.aws_fake_dsl import parse_operation_file


class TestParseOperationFileSimple:
    def test_single_operation_no_helpers(self, tmp_path: Path):
        # Arrange
        expected_operation = "get-item"
        expected_status = 200
        expected_body = "faked"
        service = "dynamodb"
        op_file = tmp_path / "get_item.yaml"
        op_file.write_text(
            "operations:\n"
            "  - operation: get-item\n"
            "    response:\n"
            "      status: 200\n"
            "      body: faked\n"
        )

        # Act
        rules = parse_operation_file(op_file, service, tmp_path)

        # Assert
        assert len(rules) == 1, f"Expected {1!r} but got {len(rules)!r}"
        actual_operation = rules[0].operation
        actual_status = rules[0].response.status
        actual_body = rules[0].response.body
        assert actual_operation == expected_operation, (
            f"Expected {expected_operation!r} but got {actual_operation!r}"
        )
        assert actual_status == expected_status, (
            f"Expected {expected_status!r} but got {actual_status!r}"
        )
        assert actual_body == expected_body, f"Expected {expected_body!r} but got {actual_body!r}"
