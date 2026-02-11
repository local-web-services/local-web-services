from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestPurgeQueue:
    def test_purge_queue(self, e2e_port, lws_invoke, assert_invoke):
        # Arrange
        queue_name = "e2e-purge-q"
        lws_invoke(["sqs", "create-queue", "--queue-name", queue_name, "--port", str(e2e_port)])
        lws_invoke(
            [
                "sqs",
                "send-message",
                "--queue-name",
                queue_name,
                "--message-body",
                "msg1",
                "--port",
                str(e2e_port),
            ]
        )

        # Act
        result = runner.invoke(
            app,
            [
                "sqs",
                "purge-queue",
                "--queue-name",
                queue_name,
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
        verify = assert_invoke(
            [
                "sqs",
                "get-queue-attributes",
                "--queue-name",
                queue_name,
                "--port",
                str(e2e_port),
            ]
        )
        attrs = (
            verify.get("GetQueueAttributesResponse", {})
            .get("GetQueueAttributesResult", {})
            .get("Attribute", [])
        )
        if isinstance(attrs, dict):
            attrs = [attrs]
        actual_count = next(
            (a["Value"] for a in attrs if a.get("Name") == "ApproximateNumberOfMessages"),
            None,
        )
        assert actual_count == "0"
