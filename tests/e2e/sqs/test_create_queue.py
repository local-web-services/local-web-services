from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestCreateQueue:
    def test_create_queue(self, e2e_port, lws_invoke, assert_invoke):
        # Arrange
        queue_name = "e2e-create-q"

        # Act
        result = runner.invoke(
            app,
            [
                "sqs",
                "create-queue",
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
        assert any(queue_name in u for u in urls)
