import json

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestListTopics:
    def test_list_topics(self, e2e_port, lws_invoke):
        # Arrange
        topic_name = "e2e-list-topics"
        lws_invoke(["sns", "create-topic", "--name", topic_name, "--port", str(e2e_port)])

        # Act
        result = runner.invoke(
            app,
            [
                "sns",
                "list-topics",
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
        data = json.loads(result.output)
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
