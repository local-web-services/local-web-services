import json

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestRemoveTagsFromResource:
    def test_remove_tags_from_resource(self, e2e_port, lws_invoke):
        # Arrange
        param_name = "/e2e/remove-tags-test"
        lws_invoke(
            [
                "ssm",
                "put-parameter",
                "--name",
                param_name,
                "--value",
                "val1",
                "--type",
                "String",
                "--port",
                str(e2e_port),
            ]
        )
        lws_invoke(
            [
                "ssm",
                "add-tags-to-resource",
                "--resource-type",
                "Parameter",
                "--resource-id",
                param_name,
                "--tags",
                json.dumps([{"Key": "env", "Value": "test"}]),
                "--port",
                str(e2e_port),
            ]
        )

        # Act
        result = runner.invoke(
            app,
            [
                "ssm",
                "remove-tags-from-resource",
                "--resource-type",
                "Parameter",
                "--resource-id",
                param_name,
                "--tag-keys",
                json.dumps(["env"]),
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
