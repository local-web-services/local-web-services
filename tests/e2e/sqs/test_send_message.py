from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestSendMessage:
    def test_send_message(self, e2e_port, lws_invoke, assert_invoke):
        # Arrange
        queue_name = "e2e-send-msg"
        expected_body = "hello from e2e"
        lws_invoke(["sqs", "create-queue", "--queue-name", queue_name, "--port", str(e2e_port)])

        # Act
        result = runner.invoke(
            app,
            [
                "sqs",
                "send-message",
                "--queue-name",
                queue_name,
                "--message-body",
                expected_body,
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
        verify = assert_invoke(
            ["sqs", "receive-message", "--queue-name", queue_name, "--port", str(e2e_port)]
        )
        actual_body = (
            verify.get("ReceiveMessageResponse", {})
            .get("ReceiveMessageResult", {})
            .get("Message", {})
            .get("Body")
        )
        assert actual_body == expected_body
