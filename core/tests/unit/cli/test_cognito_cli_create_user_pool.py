"""Tests for Cognito CLI management commands."""

from __future__ import annotations

from unittest.mock import AsyncMock, patch

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


def _mock_client(return_value: dict) -> AsyncMock:
    mock = AsyncMock()
    mock.json_target_request = AsyncMock(return_value=return_value)
    mock.service_port = AsyncMock(return_value=3007)
    return mock


class TestCreateUserPool:
    def test_create_user_pool(self) -> None:
        # Arrange
        expected_exit_code = 0
        expected_target = "CreateUserPool"
        resp = {"UserPool": {"Id": "us-east-1_default", "Name": "my-pool"}}
        mock = _mock_client(resp)

        # Act
        with patch("lws.cli.services.cognito._client", return_value=mock):
            result = runner.invoke(
                app,
                ["cognito-idp", "create-user-pool", "--pool-name", "my-pool"],
            )

        # Assert
        assert result.exit_code == expected_exit_code
        mock.json_target_request.assert_awaited_once()
        actual_target = mock.json_target_request.call_args[0][1]
        assert expected_target in actual_target
