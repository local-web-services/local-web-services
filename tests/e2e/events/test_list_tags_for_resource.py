from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestListTagsForResource:
    def test_list_tags_for_resource(self, e2e_port, lws_invoke):
        # Arrange
        bus_name = "e2e-list-tags-bus"
        lws_invoke(["events", "create-event-bus", "--name", bus_name, "--port", str(e2e_port)])
        resource_arn = "arn:aws:events:us-east-1:000000000000:event-bus/e2e-list-tags-bus"

        # Act
        result = runner.invoke(
            app,
            [
                "events",
                "list-tags-for-resource",
                "--resource-arn",
                resource_arn,
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
