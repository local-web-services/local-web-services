import json

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()

PASS_DEFINITION = json.dumps({"StartAt": "Pass", "States": {"Pass": {"Type": "Pass", "End": True}}})


class TestGetExecutionHistory:
    def test_get_execution_history(self, e2e_port, lws_invoke):
        # Arrange
        sm_name = "e2e-get-hist"
        lws_invoke(
            [
                "stepfunctions",
                "create-state-machine",
                "--name",
                sm_name,
                "--definition",
                PASS_DEFINITION,
                "--role-arn",
                "arn:aws:iam::000000000000:role/test",
                "--port",
                str(e2e_port),
            ]
        )
        start_output = lws_invoke(
            [
                "stepfunctions",
                "start-execution",
                "--name",
                sm_name,
                "--input",
                "{}",
                "--port",
                str(e2e_port),
            ]
        )
        execution_arn = start_output["executionArn"]

        # Act
        result = runner.invoke(
            app,
            [
                "stepfunctions",
                "get-execution-history",
                "--execution-arn",
                execution_arn,
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
