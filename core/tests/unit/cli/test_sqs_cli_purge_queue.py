"""Tests for SQS CLI queue management commands."""

from __future__ import annotations

from unittest.mock import AsyncMock, patch

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


def _fake_client_xml(return_xml: str) -> AsyncMock:
    fake = AsyncMock()
    fake.form_request = AsyncMock(return_value=return_xml)
    fake.service_port = AsyncMock(return_value=3002)
    return fake


class TestPurgeQueue:
    def test_purge_queue_calls_correct_endpoint(self) -> None:
        # Arrange
        expected_exit_code = 0
        expected_action = "PurgeQueue"
        expected_queue_name = "my-queue"
        xml = "<PurgeQueueResponse><ResponseMetadata></ResponseMetadata></PurgeQueueResponse>"
        fake = _fake_client_xml(xml)

        # Act
        with patch("lws.cli.services.sqs._client", return_value=fake):
            result = runner.invoke(
                app,
                ["sqs", "purge-queue", "--queue-name", expected_queue_name],
            )

        # Assert
        assert result.exit_code == expected_exit_code
        fake.form_request.assert_awaited_once()
        actual_params = fake.form_request.call_args[0][1]
        assert actual_params["Action"] == expected_action
        assert expected_queue_name in actual_params["QueueUrl"]
