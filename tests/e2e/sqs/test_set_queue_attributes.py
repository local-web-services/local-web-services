from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestSetQueueAttributes:
    def test_set_queue_attributes(self, e2e_port, lws_invoke):
        # Arrange
        queue_name = "e2e-set-queue-attrs"
        lws_invoke(["sqs", "create-queue", "--queue-name", queue_name, "--port", str(e2e_port)])

        # Act
        result = runner.invoke(
            app,
            [
                "sqs",
                "set-queue-attributes",
                "--queue-name",
                queue_name,
                "--attributes",
                '{"VisibilityTimeout":"30"}',
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
