"""Tests for EventBridge CLI management commands."""

from __future__ import annotations

from unittest.fake import AsyncFake, patch

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


def _fake_client(return_value: dict) -> AsyncFake:
    fake = AsyncFake()
    fake.json_target_request = AsyncFake(return_value=return_value)
    fake.service_port = AsyncFake(return_value=3005)
    return fake


class TestDeleteEventBus:
    def test_delete_event_bus(self) -> None:
        # Arrange
        expected_exit_code = 0
        expected_target = "DeleteEventBus"
        fake = _fake_client({})

        # Act
        with patch("lws.cli.services.events._client", return_value=fake):
            result = runner.invoke(
                app,
                ["events", "delete-event-bus", "--name", "my-bus"],
            )

        # Assert
        assert result.exit_code == expected_exit_code
        fake.json_target_request.assert_awaited_once()
        actual_target = fake.json_target_request.call_args[0][1]
        assert expected_target in actual_target
