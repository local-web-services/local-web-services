"""Tests for SNS CLI topic management commands."""

from __future__ import annotations

from unittest.mock import AsyncMock, patch

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


def _mock_client_xml(return_xml: str) -> AsyncMock:
    mock = AsyncMock()
    mock.form_request = AsyncMock(return_value=return_xml)
    mock.service_port = AsyncMock(return_value=3004)
    return mock


class TestCreateTopic:
    def test_create_topic_calls_correct_endpoint(self) -> None:
        xml = (
            "<CreateTopicResponse>"
            "<CreateTopicResult>"
            "<TopicArn>arn:aws:sns:us-east-1:000000000000:my-topic</TopicArn>"
            "</CreateTopicResult>"
            "</CreateTopicResponse>"
        )
        mock = _mock_client_xml(xml)
        with patch("lws.cli.services.sns._client", return_value=mock):
            result = runner.invoke(
                app,
                ["sns", "create-topic", "--name", "my-topic"],
            )

        assert result.exit_code == 0
        mock.form_request.assert_awaited_once()
        call_args = mock.form_request.call_args
        params = call_args[0][1]
        assert params["Action"] == "CreateTopic"
        assert params["Name"] == "my-topic"
