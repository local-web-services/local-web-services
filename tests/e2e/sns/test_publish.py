import json

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestPublish:
    def test_publish(self, e2e_port, lws_invoke):
        # Arrange
        topic_name = "e2e-publish-topic"
        lws_invoke(["sns", "create-topic", "--name", topic_name, "--port", str(e2e_port)])

        # Act
        result = runner.invoke(
            app,
            [
                "sns",
                "publish",
                "--topic-name",
                topic_name,
                "--message",
                "hello from e2e",
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
        assert "PublishResponse" in json.loads(result.output)
