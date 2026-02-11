import json

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestPutRule:
    def test_put_rule(self, e2e_port, lws_invoke, assert_invoke):
        # Arrange
        rule_name = "e2e-put-rule"
        pattern = json.dumps({"source": ["e2e.test"]})

        # Act
        result = runner.invoke(
            app,
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
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
        verify = assert_invoke(
            ["events", "list-rules", "--event-bus-name", "default", "--port", str(e2e_port)]
        )
        actual_names = [r["Name"] for r in verify.get("Rules", [])]
        assert rule_name in actual_names
