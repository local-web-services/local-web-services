import json

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestDeleteRule:
    def test_delete_rule(self, e2e_port, lws_invoke, assert_invoke):
        # Arrange
        rule_name = "e2e-del-rule"
        pattern = json.dumps({"source": ["e2e.test"]})
        lws_invoke(
            [
                "events",
                "put-rule",
                "--name",
                rule_name,
                "--event-bus-name",
                "default",
                "--event-pattern",
                pattern,
                "--port",
                str(e2e_port),
            ]
        )

        # Act
        result = runner.invoke(
            app,
            [
                "events",
                "delete-rule",
                "--name",
                rule_name,
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
        verify = assert_invoke(
            ["events", "list-rules", "--event-bus-name", "default", "--port", str(e2e_port)]
        )
        actual_names = [r["Name"] for r in verify.get("Rules", [])]
        assert rule_name not in actual_names
