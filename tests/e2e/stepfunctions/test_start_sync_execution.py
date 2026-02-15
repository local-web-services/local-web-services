import json

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()

PASS_DEFINITION = json.dumps({"StartAt": "Pass", "States": {"Pass": {"Type": "Pass", "End": True}}})


class TestStartSyncExecution:
    def test_start_sync_execution(self, e2e_port, lws_invoke):
        # Arrange
        sm_name = "e2e-start-sync"
        lws_invoke(
            [
                "stepfunctions",
                "create-state-machine",
                "--name",
                sm_name,
                "--definition",
                PASS_DEFINITION,
                "--type",
                "EXPRESS",
                "--port",
                str(e2e_port),
            ]
        )

        # Act
        result = runner.invoke(
            app,
            [
                "stepfunctions",
                "start-sync-execution",
                "--name",
                sm_name,
                "--input",
                "{}",
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
