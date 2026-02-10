"""Tests for SQS CLI queue management commands."""

from __future__ import annotations

from unittest.mock import AsyncMock, patch

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


def _mock_client_xml(return_xml: str) -> AsyncMock:
    mock = AsyncMock()
    mock.form_request = AsyncMock(return_value=return_xml)
    mock.service_port = AsyncMock(return_value=3002)
    return mock


class TestDeleteQueue:
    def test_delete_queue_calls_correct_endpoint(self) -> None:
        xml = "<DeleteQueueResponse><ResponseMetadata></ResponseMetadata></DeleteQueueResponse>"
        mock = _mock_client_xml(xml)
        with patch("lws.cli.services.sqs._client", return_value=mock):
            result = runner.invoke(
                app,
                ["sqs", "delete-queue", "--queue-name", "my-queue"],
            )

        assert result.exit_code == 0
        mock.form_request.assert_awaited_once()
        call_args = mock.form_request.call_args
        params = call_args[0][1]
        assert params["Action"] == "DeleteQueue"
        assert "my-queue" in params["QueueUrl"]
