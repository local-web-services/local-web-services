import json

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()

PASS_DEFINITION = json.dumps({"StartAt": "Pass", "States": {"Pass": {"Type": "Pass", "End": True}}})


class TestListStateMachineVersions:
    def test_list_state_machine_versions(self, e2e_port, lws_invoke):
        # Arrange
        sm_name = "e2e-list-versions"
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
                "list-state-machine-versions",
                "--name",
                sm_name,
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
