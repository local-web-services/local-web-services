import json

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()

PASS_DEFINITION = json.dumps({"StartAt": "Pass", "States": {"Pass": {"Type": "Pass", "End": True}}})


class TestDescribeExecution:
    def test_describe_execution(self, e2e_port, lws_invoke):
        # Arrange
        sm_name = "e2e-desc-exec"
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
        expected_arn = start_output["executionArn"]

        # Act
        result = runner.invoke(
            app,
            [
                "stepfunctions",
                "describe-execution",
                "--execution-arn",
                expected_arn,
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
        data = json.loads(result.output)
        actual_arn = data["executionArn"]
        assert actual_arn == expected_arn
        assert "status" in data
