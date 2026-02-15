import json

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestPutTargets:
    def test_put_targets(self, e2e_port, lws_invoke):
        # Arrange
        rule_name = "e2e-put-targets-rule"
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
        targets = json.dumps(
            [{"Id": "t1", "Arn": "arn:aws:lambda:us-east-1:000000000000:function:fn"}]
        )

        # Act
        result = runner.invoke(
            app,
            [
                "events",
                "put-targets",
                "--rule",
                rule_name,
                "--targets",
                targets,
                "--event-bus-name",
                "default",
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
