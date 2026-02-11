from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestCreateTopic:
    def test_create_topic(self, e2e_port, lws_invoke, assert_invoke):
        # Arrange
        topic_name = "e2e-create-topic"

        # Act
        result = runner.invoke(
            app,
            [
                "sns",
                "create-topic",
                "--name",
                topic_name,
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
        data = assert_invoke(["sns", "list-topics", "--port", str(e2e_port)])
        topics = (
            data.get("ListTopicsResponse", {})
            .get("ListTopicsResult", {})
            .get("Topics", {})
            .get("member", [])
        )
        if isinstance(topics, dict):
            topics = [topics]
        actual_arns = [t.get("TopicArn", "") for t in topics]
        assert any(topic_name in a for a in actual_arns)
