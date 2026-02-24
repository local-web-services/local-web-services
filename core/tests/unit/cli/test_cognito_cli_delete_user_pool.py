"""Tests for Cognito CLI management commands."""

from __future__ import annotations

from unittest.mock import AsyncMock, patch

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


def _fake_client(return_value: dict) -> AsyncMock:
    fake = AsyncMock()
    fake.json_target_request = AsyncMock(return_value=return_value)
    fake.service_port = AsyncMock(return_value=3007)
    return fake


class TestDeleteUserPool:
    def test_delete_user_pool(self) -> None:
        # Arrange
        expected_exit_code = 0
        expected_target = "DeleteUserPool"
        fake = _fake_client({})

        # Act
        with patch("lws.cli.services.cognito._client", return_value=fake):
            result = runner.invoke(
                app,
                ["cognito-idp", "delete-user-pool", "--user-pool-id", "us-east-1_default"],
            )

        # Assert
        assert result.exit_code == expected_exit_code
        fake.json_target_request.assert_awaited_once()
        actual_target = fake.json_target_request.call_args[0][1]
        assert expected_target in actual_target
