"""Unit tests for parse_operation_file simple case."""

from __future__ import annotations

from pathlib import Path

from lws.providers._shared.aws_mock_dsl import parse_operation_file


class TestParseOperationFileSimple:
    def test_single_operation_no_helpers(self, tmp_path: Path):
        # Arrange
        expected_operation = "get-item"
        expected_status = 200
        expected_body = "mocked"
        service = "dynamodb"
        op_file = tmp_path / "get_item.yaml"
        op_file.write_text(
            "operations:\n"
            "  - operation: get-item\n"
            "    response:\n"
            "      status: 200\n"
            "      body: mocked\n"
        )

        # Act
        rules = parse_operation_file(op_file, service, tmp_path)

        # Assert
        assert len(rules) == 1
        actual_operation = rules[0].operation
        actual_status = rules[0].response.status
        actual_body = rules[0].response.body
        assert actual_operation == expected_operation
        assert actual_status == expected_status
        assert actual_body == expected_body
