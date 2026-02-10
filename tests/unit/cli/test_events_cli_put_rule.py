"""Tests for EventBridge CLI management commands."""

from __future__ import annotations

from unittest.mock import AsyncMock, patch

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


def _mock_client(return_value: dict) -> AsyncMock:
    mock = AsyncMock()
    mock.json_target_request = AsyncMock(return_value=return_value)
    mock.service_port = AsyncMock(return_value=3005)
    return mock


class TestPutRule:
    def test_put_rule(self) -> None:
        resp = {"RuleArn": "arn:aws:events:us-east-1:000000000000:rule/my-rule"}
        mock = _mock_client(resp)
        with patch("lws.cli.services.events._client", return_value=mock):
            result = runner.invoke(
                app,
                ["events", "put-rule", "--name", "my-rule"],
            )

        assert result.exit_code == 0
        mock.json_target_request.assert_awaited_once()
        call_args = mock.json_target_request.call_args
        assert "PutRule" in call_args[0][1]
