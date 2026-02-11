import json

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestPutEvents:
    def test_put_events(self, e2e_port, lws_invoke):
        # Arrange
        entries = json.dumps(
            [
                {
                    "Source": "e2e.test",
                    "DetailType": "TestEvent",
                    "Detail": '{"key": "value"}',
                    "EventBusName": "default",
                }
            ]
        )

        # Act
        result = runner.invoke(
            app,
            [
                "events",
                "put-events",
                "--entries",
                entries,
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
        actual_failed = json.loads(result.output).get("FailedEntryCount", -1)
        assert actual_failed == 0
