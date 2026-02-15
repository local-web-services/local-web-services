from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestDescribeEventBus:
    def test_describe_event_bus(self, e2e_port):
        # Arrange
        target_eb = "default"

        # Act
        result = runner.invoke(
            app,
            [
                "events",
                "describe-event-bus",
                "--name",
                target_eb,
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
