from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestTagQueue:
    def test_tag_queue(self, e2e_port, lws_invoke):
        # Arrange
        queue_name = "e2e-tag-q"
        lws_invoke(["sqs", "create-queue", "--queue-name", queue_name, "--port", str(e2e_port)])

        # Act
        result = runner.invoke(
            app,
            [
                "sqs",
                "tag-queue",
                "--queue-name",
                queue_name,
                "--tags",
                '{"env":"test"}',
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
