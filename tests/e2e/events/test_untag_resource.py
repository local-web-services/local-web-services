import json

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestUntagResource:
    def test_untag_resource(self, e2e_port, lws_invoke):
        # Arrange
        bus_name = "e2e-untag-bus"
        lws_invoke(["events", "create-event-bus", "--name", bus_name, "--port", str(e2e_port)])
        resource_arn = "arn:aws:events:us-east-1:000000000000:event-bus/e2e-untag-bus"
        tags = json.dumps([{"Key": "env", "Value": "test"}])
        lws_invoke(
            [
                "events",
                "tag-resource",
                "--resource-arn",
                resource_arn,
                "--tags",
                tags,
                "--port",
                str(e2e_port),
            ]
        )
        tag_keys = json.dumps(["env"])

        # Act
        result = runner.invoke(
            app,
            [
                "events",
                "untag-resource",
                "--resource-arn",
                resource_arn,
                "--tag-keys",
                tag_keys,
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
