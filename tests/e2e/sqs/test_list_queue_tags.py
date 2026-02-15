from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestListQueueTags:
    def test_list_queue_tags(self, e2e_port, lws_invoke):
        # Arrange
        queue_name = "e2e-list-q-tags"
        lws_invoke(["sqs", "create-queue", "--queue-name", queue_name, "--port", str(e2e_port)])

        # Act
        result = runner.invoke(
            app,
            [
                "sqs",
                "list-queue-tags",
                "--queue-name",
                queue_name,
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
