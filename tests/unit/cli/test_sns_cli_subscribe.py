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


class TestSubscribe:
    def test_subscribe_calls_correct_endpoint(self) -> None:
        xml = (
            "<SubscribeResponse>"
            "<SubscribeResult>"
            "<SubscriptionArn>arn:aws:sns:us-east-1:000000000000:my-topic:abc123</SubscriptionArn>"
            "</SubscribeResult>"
            "</SubscribeResponse>"
        )
        mock = _mock_client_xml(xml)
        topic_arn = "arn:aws:sns:us-east-1:000000000000:my-topic"
        with patch("lws.cli.services.sns._client", return_value=mock):
            result = runner.invoke(
                app,
                [
                    "sns",
                    "subscribe",
                    "--topic-arn",
                    topic_arn,
                    "--protocol",
                    "sqs",
                    "--notification-endpoint",
                    "arn:aws:sqs:us-east-1:000000000000:my-queue",
                ],
            )

        assert result.exit_code == 0
        mock.form_request.assert_awaited_once()
        call_args = mock.form_request.call_args
        params = call_args[0][1]
        assert params["Action"] == "Subscribe"
        assert params["TopicArn"] == topic_arn
        assert params["Protocol"] == "sqs"
