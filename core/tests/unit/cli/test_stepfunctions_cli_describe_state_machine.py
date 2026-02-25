"""Tests for Step Functions CLI management commands."""

from __future__ import annotations

from unittest.mock import AsyncMock, patch

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


def _fake_client(return_value: dict) -> AsyncMock:
    fake = AsyncMock()
    fake.json_target_request = AsyncMock(return_value=return_value)
    fake.service_port = AsyncMock(return_value=3006)
    return fake


class TestDescribeStateMachine:
    def test_describe_state_machine(self) -> None:
        # Arrange
        expected_exit_code = 0
        expected_target = "DescribeStateMachine"
        resp = {
            "name": "test-sm",
            "stateMachineArn": "arn:aws:states:us-east-1:000000000000:stateMachine:test-sm",
            "status": "ACTIVE",
        }
        fake = _fake_client(resp)

        # Act
        with patch("lws.cli.services.stepfunctions._client", return_value=fake):
            result = runner.invoke(
                app,
                ["stepfunctions", "describe-state-machine", "--name", "test-sm"],
            )

        # Assert
        assert result.exit_code == expected_exit_code
        fake.json_target_request.assert_awaited_once()
        actual_target = fake.json_target_request.call_args[0][1]
        assert expected_target in actual_target
