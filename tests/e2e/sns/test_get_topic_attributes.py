from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestGetTopicAttributes:
    def test_get_topic_attributes(self, e2e_port, lws_invoke):
        # Arrange
        topic_name = "e2e-get-topic-attrs"
        data = lws_invoke(["sns", "create-topic", "--name", topic_name, "--port", str(e2e_port)])
        default_arn = f"arn:aws:sns:us-east-1:000000000000:{topic_name}"
        topic_arn = (
            data.get("CreateTopicResponse", {})
            .get("CreateTopicResult", {})
            .get("TopicArn", default_arn)
        )

        # Act
        result = runner.invoke(
            app,
            [
                "sns",
                "get-topic-attributes",
                "--topic-arn",
                topic_arn,
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
