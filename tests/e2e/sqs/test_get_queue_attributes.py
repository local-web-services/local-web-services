import json

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestGetQueueAttributes:
    def test_get_queue_attributes(self, e2e_port, lws_invoke):
        # Arrange
        queue_name = "e2e-getattr-q"
        lws_invoke(["sqs", "create-queue", "--queue-name", queue_name, "--port", str(e2e_port)])

        # Act
        result = runner.invoke(
            app,
            [
                "sqs",
                "get-queue-attributes",
                "--queue-name",
                queue_name,
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
        assert "GetQueueAttributesResponse" in json.loads(result.output)
