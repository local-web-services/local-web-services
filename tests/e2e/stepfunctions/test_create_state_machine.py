import json

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()

PASS_DEFINITION = json.dumps({"StartAt": "Pass", "States": {"Pass": {"Type": "Pass", "End": True}}})


class TestCreateStateMachine:
    def test_create_state_machine(self, e2e_port, lws_invoke, assert_invoke):
        # Arrange
        sm_name = "e2e-create-sm"

        # Act
        result = runner.invoke(
            app,
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
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
        verify = assert_invoke(
            ["stepfunctions", "describe-state-machine", "--name", sm_name, "--port", str(e2e_port)]
        )
        actual_name = verify["name"]
        assert actual_name == sm_name
