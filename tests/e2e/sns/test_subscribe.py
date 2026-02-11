from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestSubscribe:
    def test_subscribe(self, e2e_port, lws_invoke, assert_invoke):
        # Arrange
        topic_name = "e2e-sub-topic"
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
                "subscribe",
                "--topic-arn",
                topic_arn,
                "--protocol",
                "sqs",
                "--notification-endpoint",
                "arn:aws:sqs:us-east-1:000000000000:e2e-sub-queue",
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
        vdata = assert_invoke(["sns", "list-subscriptions", "--port", str(e2e_port)])
        subs = (
            vdata.get("ListSubscriptionsResponse", {})
            .get("ListSubscriptionsResult", {})
            .get("Subscriptions", {})
            .get("member", [])
        )
        if isinstance(subs, dict):
            subs = [subs]
        actual_topic_arns = [s.get("TopicArn", "") for s in subs]
        assert topic_arn in actual_topic_arns
