import json

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()

PASS_DEFINITION = json.dumps({"StartAt": "Pass", "States": {"Pass": {"Type": "Pass", "End": True}}})


class TestStartExecution:
    def test_start_execution(self, e2e_port, lws_invoke, assert_invoke):
        # Arrange
        sm_name = "e2e-start-exec"
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

        # Act
        result = runner.invoke(
            app,
            [
                "stepfunctions",
                "start-execution",
                "--name",
                sm_name,
                "--input",
                '{"key": "value"}',
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
        data = json.loads(result.output)
        assert "executionArn" in data
        verify = assert_invoke(
            [
                "stepfunctions",
                "describe-execution",
                "--execution-arn",
                data["executionArn"],
                "--port",
                str(e2e_port),
            ]
        )
        assert "status" in verify
