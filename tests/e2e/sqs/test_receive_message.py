import json

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestReceiveMessage:
    def test_receive_message(self, e2e_port, lws_invoke):
        # Arrange
        queue_name = "e2e-recv-msg"
        expected_body = "test-body"
        lws_invoke(["sqs", "create-queue", "--queue-name", queue_name, "--port", str(e2e_port)])
        lws_invoke(
            [
                "sqs",
                "send-message",
                "--queue-name",
                queue_name,
                "--message-body",
                expected_body,
                "--port",
                str(e2e_port),
            ]
        )

        # Act
        result = runner.invoke(
            app,
            [
                "sqs",
                "receive-message",
                "--queue-name",
                queue_name,
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
        actual_body = (
            json.loads(result.output)
            .get("ReceiveMessageResponse", {})
            .get("ReceiveMessageResult", {})
            .get("Message", {})
            .get("Body")
        )
        assert actual_body == expected_body
