from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestGetQueueUrl:
    def test_get_queue_url(self, e2e_port, lws_invoke):
        # Arrange
        queue_name = "e2e-get-queue-url"
        lws_invoke(["sqs", "create-queue", "--queue-name", queue_name, "--port", str(e2e_port)])

        # Act
        result = runner.invoke(
            app,
            [
                "sqs",
                "get-queue-url",
                "--queue-name",
                queue_name,
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
