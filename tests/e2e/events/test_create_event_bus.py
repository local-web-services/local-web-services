from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestCreateEventBus:
    def test_create_event_bus(self, e2e_port, lws_invoke, assert_invoke):
        # Arrange
        bus_name = "e2e-create-bus"

        # Act
        result = runner.invoke(
            app,
            [
                "events",
                "create-event-bus",
                "--name",
                bus_name,
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
        verify = assert_invoke(["events", "list-event-buses", "--port", str(e2e_port)])
        actual_names = [b["Name"] for b in verify.get("EventBuses", [])]
        assert bus_name in actual_names
