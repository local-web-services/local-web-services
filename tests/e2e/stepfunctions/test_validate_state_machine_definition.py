import json

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()

PASS_DEFINITION = json.dumps({"StartAt": "Pass", "States": {"Pass": {"Type": "Pass", "End": True}}})


class TestValidateStateMachineDefinition:
    def test_validate_state_machine_definition(self, e2e_port):
        # Arrange
        definition = PASS_DEFINITION

        # Act
        result = runner.invoke(
            app,
            [
                "stepfunctions",
                "validate-state-machine-definition",
                "--definition",
                definition,
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
