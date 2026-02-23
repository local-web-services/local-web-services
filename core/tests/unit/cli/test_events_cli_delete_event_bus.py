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


class TestDeleteEventBus:
    def test_delete_event_bus(self) -> None:
        # Arrange
        expected_exit_code = 0
        expected_target = "DeleteEventBus"
        mock = _mock_client({})

        # Act
        with patch("lws.cli.services.events._client", return_value=mock):
            result = runner.invoke(
                app,
                ["events", "delete-event-bus", "--name", "my-bus"],
            )

        # Assert
        assert result.exit_code == expected_exit_code
        mock.json_target_request.assert_awaited_once()
        actual_target = mock.json_target_request.call_args[0][1]
        assert expected_target in actual_target
