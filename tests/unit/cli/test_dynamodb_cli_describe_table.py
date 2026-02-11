"""Tests for DynamoDB CLI table management commands."""

from __future__ import annotations

from unittest.mock import AsyncMock, patch

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()

_TARGET_PREFIX = "DynamoDB_20120810"


def _mock_client_response(return_value: dict) -> AsyncMock:
    mock = AsyncMock()
    mock.json_target_request = AsyncMock(return_value=return_value)
    return mock


class TestDescribeTable:
    def test_describe_table_calls_correct_endpoint(self) -> None:
        # Arrange
        expected_exit_code = 0
        expected_target = f"{_TARGET_PREFIX}.DescribeTable"
        expected_table_name = "MyTable"
        expected_body = {"TableName": expected_table_name}
        mock = _mock_client_response({"Table": {"TableName": expected_table_name}})

        # Act
        with patch("lws.cli.services.dynamodb._client", return_value=mock):
            result = runner.invoke(
                app,
                ["dynamodb", "describe-table", "--table-name", expected_table_name],
            )

        # Assert
        assert result.exit_code == expected_exit_code
        mock.json_target_request.assert_awaited_once()
        call_args = mock.json_target_request.call_args
        actual_target = call_args[0][1]
        actual_body = call_args[0][2]
        assert actual_target == expected_target
        assert actual_body == expected_body
