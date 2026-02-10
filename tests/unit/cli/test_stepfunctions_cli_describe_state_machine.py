"""Tests for Step Functions CLI management commands."""

from __future__ import annotations

from unittest.mock import AsyncMock, patch

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


def _mock_client(return_value: dict) -> AsyncMock:
    mock = AsyncMock()
    mock.json_target_request = AsyncMock(return_value=return_value)
    mock.service_port = AsyncMock(return_value=3006)
    return mock


class TestDescribeStateMachine:
    def test_describe_state_machine(self) -> None:
        resp = {
            "name": "test-sm",
            "stateMachineArn": "arn:aws:states:us-east-1:000000000000:stateMachine:test-sm",
            "status": "ACTIVE",
        }
        mock = _mock_client(resp)
        with patch("lws.cli.services.stepfunctions._client", return_value=mock):
            result = runner.invoke(
                app,
                ["stepfunctions", "describe-state-machine", "--name", "test-sm"],
            )

        assert result.exit_code == 0
        mock.json_target_request.assert_awaited_once()
        call_args = mock.json_target_request.call_args
        assert "DescribeStateMachine" in call_args[0][1]
