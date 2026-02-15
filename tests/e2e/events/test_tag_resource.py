import json

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestTagResource:
    def test_tag_resource(self, e2e_port, lws_invoke):
        # Arrange
        bus_name = "e2e-tag-bus"
        lws_invoke(["events", "create-event-bus", "--name", bus_name, "--port", str(e2e_port)])
        resource_arn = "arn:aws:events:us-east-1:000000000000:event-bus/e2e-tag-bus"
        tags = json.dumps([{"Key": "env", "Value": "test"}])

        # Act
        result = runner.invoke(
            app,
            [
                "events",
                "tag-resource",
                "--resource-arn",
                resource_arn,
                "--tags",
                tags,
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
