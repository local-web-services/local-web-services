from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestDeleteTopic:
    def test_delete_topic(self, e2e_port, lws_invoke, assert_invoke):
        # Arrange
        topic_name = "e2e-del-topic"
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
                "delete-topic",
                "--topic-arn",
                topic_arn,
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
        vdata = assert_invoke(["sns", "list-topics", "--port", str(e2e_port)])
        topics = (
            vdata.get("ListTopicsResponse", {})
            .get("ListTopicsResult", {})
            .get("Topics", {})
            .get("member", [])
        )
        if isinstance(topics, dict):
            topics = [topics]
        actual_arns = [t.get("TopicArn", "") for t in topics]
        assert not any(topic_name in a for a in actual_arns)
