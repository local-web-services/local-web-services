from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestListDeadLetterSourceQueues:
    def test_list_dead_letter_source_queues(self, e2e_port, lws_invoke):
        # Arrange
        queue_name = "e2e-list-dlq-src"
        lws_invoke(["sqs", "create-queue", "--queue-name", queue_name, "--port", str(e2e_port)])

        # Act
        result = runner.invoke(
            app,
            [
                "sqs",
                "list-dead-letter-source-queues",
                "--queue-name",
                queue_name,
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
