from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestDeleteQueue:
    def test_delete_queue(self, e2e_port, lws_invoke, assert_invoke):
        # Arrange
        queue_name = "e2e-del-q"
        lws_invoke(["sqs", "create-queue", "--queue-name", queue_name, "--port", str(e2e_port)])

        # Act
        result = runner.invoke(
            app,
            [
                "sqs",
                "delete-queue",
                "--queue-name",
                queue_name,
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
        data = assert_invoke(["sqs", "list-queues", "--port", str(e2e_port)])
        urls = data.get("ListQueuesResponse", {}).get("ListQueuesResult", {}).get("QueueUrl", [])
        if isinstance(urls, str):
            urls = [urls]
        assert not any(queue_name in u for u in urls)
