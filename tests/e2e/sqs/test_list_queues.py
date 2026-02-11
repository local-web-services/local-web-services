import json

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestListQueues:
    def test_list_queues(self, e2e_port, lws_invoke):
        # Arrange
        queue_name = "e2e-list-q"
        lws_invoke(["sqs", "create-queue", "--queue-name", queue_name, "--port", str(e2e_port)])

        # Act
        result = runner.invoke(
            app,
            [
                "sqs",
                "list-queues",
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
        data = json.loads(result.output)
        urls = data.get("ListQueuesResponse", {}).get("ListQueuesResult", {}).get("QueueUrl", [])
        if isinstance(urls, str):
            urls = [urls]
        assert any(queue_name in u for u in urls)
