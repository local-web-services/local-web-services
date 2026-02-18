"""Unit tests for parse_operation_file with match headers."""

from __future__ import annotations

from pathlib import Path

from lws.providers._shared.aws_mock_dsl import parse_operation_file


class TestParseOperationFileMatchHeaders:
    def test_operation_with_match_headers(self, tmp_path: Path):
        # Arrange
        expected_operation = "put-item"
        expected_header_key = "x-custom-header"
        expected_header_value = "special"
        expected_status = 201
        service = "dynamodb"
        op_file = tmp_path / "put_item.yaml"
        op_file.write_text(
            "operations:\n"
            "  - operation: put-item\n"
            "    match:\n"
            "      headers:\n"
            "        x-custom-header: special\n"
            "    response:\n"
            "      status: 201\n"
            "      body: created\n"
        )

        # Act
        rules = parse_operation_file(op_file, service, tmp_path)

        # Assert
        assert len(rules) == 1
        actual_operation = rules[0].operation
        actual_match_headers = rules[0].match_headers
        actual_status = rules[0].response.status
        assert actual_operation == expected_operation
        assert expected_header_key in actual_match_headers
        actual_header_value = actual_match_headers[expected_header_key]
        assert actual_header_value == expected_header_value
        assert actual_status == expected_status
