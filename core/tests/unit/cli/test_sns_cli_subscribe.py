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
        # Arrange
        expected_exit_code = 0
        expected_action = "Subscribe"
        expected_topic_arn = "arn:aws:sns:us-east-1:000000000000:my-topic"
        expected_protocol = "sqs"
        xml = (
            "<SubscribeResponse>"
            "<SubscribeResult>"
            "<SubscriptionArn>arn:aws:sns:us-east-1:000000000000:my-topic:abc123</SubscriptionArn>"
            "</SubscribeResult>"
            "</SubscribeResponse>"
        )
        mock = _mock_client_xml(xml)

        # Act
        with patch("lws.cli.services.sns._client", return_value=mock):
            result = runner.invoke(
                app,
                [
                    "sns",
                    "subscribe",
                    "--topic-arn",
                    expected_topic_arn,
                    "--protocol",
                    expected_protocol,
                    "--notification-endpoint",
                    "arn:aws:sqs:us-east-1:000000000000:my-queue",
                ],
            )

        # Assert
        assert result.exit_code == expected_exit_code
        mock.form_request.assert_awaited_once()
        actual_params = mock.form_request.call_args[0][1]
        assert actual_params["Action"] == expected_action
        assert actual_params["TopicArn"] == expected_topic_arn
        assert actual_params["Protocol"] == expected_protocol
