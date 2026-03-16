"""Tests for DynamoDB CLI table management commands."""

from __future__ import annotations

from unittest.mock import AsyncMock, patch

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()

_TARGET_PREFIX = "DynamoDB_20120810"


def _fake_client_response(return_value: dict) -> AsyncMock:
    fake = AsyncMock()
    fake.json_target_request = AsyncMock(return_value=return_value)
    return fake


class TestListTables:
    def test_list_tables_calls_correct_endpoint(self) -> None:
        # Arrange
        expected_exit_code = 0
        expected_target = f"{_TARGET_PREFIX}.ListTables"
        expected_body = {}
        fake = _fake_client_response({"TableNames": ["TableA", "TableB"]})

        # Act
        with patch("lws.cli.services.dynamodb._client", return_value=fake):
            result = runner.invoke(
                app,
                ["dynamodb", "list-tables"],
            )

        # Assert
        assert result.exit_code == expected_exit_code
        fake.json_target_request.assert_awaited_once()
        call_args = fake.json_target_request.call_args
        actual_target = call_args[0][1]
        actual_body = call_args[0][2]
        assert actual_target == expected_target
        assert actual_body == expected_body
