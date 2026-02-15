import json

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestAddTagsToResource:
    def test_add_tags_to_resource(self, e2e_port, lws_invoke):
        # Arrange
        param_name = "/e2e/add-tags-test"
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

        # Act
        result = runner.invoke(
            app,
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
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
