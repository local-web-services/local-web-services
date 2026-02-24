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


class TestDeleteTopic:
    def test_delete_topic_calls_correct_endpoint(self) -> None:
        # Arrange
        expected_exit_code = 0
        expected_action = "DeleteTopic"
        expected_topic_arn = "arn:aws:sns:us-east-1:000000000000:my-topic"
        xml = "<DeleteTopicResponse><ResponseMetadata></ResponseMetadata></DeleteTopicResponse>"
        mock = _mock_client_xml(xml)

        # Act
        with patch("lws.cli.services.sns._client", return_value=mock):
            result = runner.invoke(
                app,
                ["sns", "delete-topic", "--topic-arn", expected_topic_arn],
            )

        # Assert
        assert result.exit_code == expected_exit_code
        mock.form_request.assert_awaited_once()
        actual_params = mock.form_request.call_args[0][1]
        assert actual_params["Action"] == expected_action
        assert actual_params["TopicArn"] == expected_topic_arn
