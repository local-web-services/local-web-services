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
        mock = _mock_client_response({"Table": {"TableName": "MyTable"}})
        with patch("lws.cli.services.dynamodb._client", return_value=mock):
            result = runner.invoke(
                app,
                ["dynamodb", "describe-table", "--table-name", "MyTable"],
            )

        assert result.exit_code == 0
        mock.json_target_request.assert_awaited_once()
        call_args = mock.json_target_request.call_args
        assert call_args[0][1] == f"{_TARGET_PREFIX}.DescribeTable"
        assert call_args[0][2] == {"TableName": "MyTable"}
