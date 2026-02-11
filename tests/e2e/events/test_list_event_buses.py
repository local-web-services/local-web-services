import json

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestListEventBuses:
    def test_list_event_buses(self, e2e_port, lws_invoke):
        # Arrange
        bus_name = "e2e-list-bus"
        lws_invoke(["events", "create-event-bus", "--name", bus_name, "--port", str(e2e_port)])

        # Act
        result = runner.invoke(
            app,
            [
                "events",
                "list-event-buses",
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
        actual_names = [b["Name"] for b in json.loads(result.output).get("EventBuses", [])]
        assert bus_name in actual_names
