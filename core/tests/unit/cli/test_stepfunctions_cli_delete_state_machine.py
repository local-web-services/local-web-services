"""Tests for Step Functions CLI management commands."""

from __future__ import annotations

from unittest.fake import AsyncFake, patch

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


def _fake_client(return_value: dict) -> AsyncFake:
    fake = AsyncFake()
    fake.json_target_request = AsyncFake(return_value=return_value)
    fake.service_port = AsyncFake(return_value=3006)
    return fake


class TestDeleteStateMachine:
    def test_delete_state_machine(self) -> None:
        # Arrange
        expected_exit_code = 0
        expected_target = "DeleteStateMachine"
        fake = _fake_client({})

        # Act
        with patch("lws.cli.services.stepfunctions._client", return_value=fake):
            result = runner.invoke(
                app,
                ["stepfunctions", "delete-state-machine", "--name", "test-sm"],
            )

        # Assert
        assert result.exit_code == expected_exit_code
        fake.json_target_request.assert_awaited_once()
        actual_target = fake.json_target_request.call_args[0][1]
        assert expected_target in actual_target
