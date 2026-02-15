import json

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestDescribeRule:
    def test_describe_rule(self, e2e_port, lws_invoke):
        # Arrange
        rule_name = "e2e-desc-rule"
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
                "describe-rule",
                "--name",
                rule_name,
                "--event-bus-name",
                "default",
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
