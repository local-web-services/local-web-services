from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestDeleteMessage:
    def test_delete_message(self, e2e_port, lws_invoke):
        # Arrange
        queue_name = "e2e-delmsg"
        lws_invoke(["sqs", "create-queue", "--queue-name", queue_name, "--port", str(e2e_port)])
        lws_invoke(
            [
                "sqs",
                "send-message",
                "--queue-name",
                queue_name,
                "--message-body",
                "to-delete",
                "--port",
                str(e2e_port),
            ]
        )
        recv_output = lws_invoke(
            ["sqs", "receive-message", "--queue-name", queue_name, "--port", str(e2e_port)]
        )
        receipt_handle = (
            recv_output.get("ReceiveMessageResponse", {})
            .get("ReceiveMessageResult", {})
            .get("Message", {})
            .get("ReceiptHandle", "")
        )

        # Act
        result = runner.invoke(
            app,
            [
                "sqs",
                "delete-message",
                "--queue-name",
                queue_name,
                "--receipt-handle",
                receipt_handle,
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
