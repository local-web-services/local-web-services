from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestSetSubscriptionAttributes:
    def test_set_subscription_attributes(self, e2e_port, lws_invoke):
        # Arrange
        topic_name = "e2e-set-sub-attrs"
        data = lws_invoke(["sns", "create-topic", "--name", topic_name, "--port", str(e2e_port)])
        default_arn = f"arn:aws:sns:us-east-1:000000000000:{topic_name}"
        topic_arn = (
            data.get("CreateTopicResponse", {})
            .get("CreateTopicResult", {})
            .get("TopicArn", default_arn)
        )
        sub_data = lws_invoke(
            [
                "sns",
                "subscribe",
                "--topic-arn",
                topic_arn,
                "--protocol",
                "sqs",
                "--notification-endpoint",
                "arn:aws:sqs:us-east-1:000000000000:e2e-set-sub-attrs-q",
                "--port",
                str(e2e_port),
            ]
        )
        subscription_arn = (
            sub_data.get("SubscribeResponse", {})
            .get("SubscribeResult", {})
            .get("SubscriptionArn", "")
        )

        # Act
        result = runner.invoke(
            app,
            [
                "sns",
                "set-subscription-attributes",
                "--subscription-arn",
                subscription_arn,
                "--attribute-name",
                "RawMessageDelivery",
                "--attribute-value",
                "true",
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
