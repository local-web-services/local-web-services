import json

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()

PASS_DEFINITION = json.dumps({"StartAt": "Pass", "States": {"Pass": {"Type": "Pass", "End": True}}})


class TestTagResource:
    def test_tag_resource(self, e2e_port, lws_invoke):
        # Arrange
        sm_name = "e2e-tag-sm"
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
        tags = json.dumps([{"key": "env", "value": "test"}])

        # Act
        result = runner.invoke(
            app,
            [
                "stepfunctions",
                "tag-resource",
                "--resource-arn",
                resource_arn,
                "--tags",
                tags,
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
