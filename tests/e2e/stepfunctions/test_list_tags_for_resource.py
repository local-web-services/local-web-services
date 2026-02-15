import json

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()

PASS_DEFINITION = json.dumps({"StartAt": "Pass", "States": {"Pass": {"Type": "Pass", "End": True}}})


class TestListTagsForResource:
    def test_list_tags_for_resource(self, e2e_port, lws_invoke):
        # Arrange
        sm_name = "e2e-list-tags-sm"
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
        resource_arn = f"arn:aws:states:us-east-1:000000000000:stateMachine:{sm_name}"

        # Act
        result = runner.invoke(
            app,
            [
                "stepfunctions",
                "list-tags-for-resource",
                "--resource-arn",
                resource_arn,
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
