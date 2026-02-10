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


class TestDescribeUserPool:
    def test_describe_user_pool(self) -> None:
        resp = {"UserPool": {"Id": "us-east-1_default", "Name": "default"}}
        mock = _mock_client(resp)
        with patch("lws.cli.services.cognito._client", return_value=mock):
            result = runner.invoke(
                app,
                ["cognito-idp", "describe-user-pool", "--user-pool-id", "us-east-1_default"],
            )

        assert result.exit_code == 0
        mock.json_target_request.assert_awaited_once()
        call_args = mock.json_target_request.call_args
        assert "DescribeUserPool" in call_args[0][1]
