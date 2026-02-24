"""Tests for SQS CLI queue management commands."""

from __future__ import annotations

from unittest.fake import AsyncFake, patch

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


def _fake_client_xml(return_xml: str) -> AsyncFake:
    fake = AsyncFake()
    fake.form_request = AsyncFake(return_value=return_xml)
    fake.service_port = AsyncFake(return_value=3002)
    return fake


class TestCreateQueue:
    def test_create_queue_calls_correct_endpoint(self) -> None:
        # Arrange
        expected_exit_code = 0
        expected_action = "CreateQueue"
        expected_queue_name = "my-queue"
        xml = (
            "<CreateQueueResponse>"
            "<CreateQueueResult>"
            "<QueueUrl>http://localhost:4566/000000000000/my-queue</QueueUrl>"
            "</CreateQueueResult>"
            "</CreateQueueResponse>"
        )
        fake = _fake_client_xml(xml)

        # Act
        with patch("lws.cli.services.sqs._client", return_value=fake):
            result = runner.invoke(
                app,
                ["sqs", "create-queue", "--queue-name", expected_queue_name],
            )

        # Assert
        assert result.exit_code == expected_exit_code
        fake.form_request.assert_awaited_once()
        actual_params = fake.form_request.call_args[0][1]
        assert actual_params["Action"] == expected_action
        assert actual_params["QueueName"] == expected_queue_name
