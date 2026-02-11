import json

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestListRules:
    def test_list_rules(self, e2e_port, lws_invoke):
        # Arrange — nothing needed (list rules on default bus)

        # Act
        result = runner.invoke(
            app,
            [
                "events",
                "list-rules",
                "--event-bus-name",
                "default",
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
        assert "Rules" in json.loads(result.output)
