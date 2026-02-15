from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestChangeMessageVisibilityBatch:
    def test_change_message_visibility_batch(self, e2e_port, lws_invoke):
        # Arrange
        queue_name = "e2e-chg-vis-batch"
        lws_invoke(["sqs", "create-queue", "--queue-name", queue_name, "--port", str(e2e_port)])
        lws_invoke(
            [
                "sqs",
                "send-message",
                "--queue-name",
                queue_name,
                "--message-body",
                "vis-batch-test",
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
        entries_json = (
            '[{"Id":"1","ReceiptHandle":"' + receipt_handle + '","VisibilityTimeout":60}]'
        )

        # Act
        result = runner.invoke(
            app,
            [
                "sqs",
                "change-message-visibility-batch",
                "--queue-name",
                queue_name,
                "--entries",
                entries_json,
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
