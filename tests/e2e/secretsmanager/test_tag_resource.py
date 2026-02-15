import json

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestTagResource:
    def test_tag_resource(self, e2e_port, lws_invoke):
        # Arrange
        secret_name = "e2e-tag-resource"
        lws_invoke(
            [
                "secretsmanager",
                "create-secret",
                "--name",
                secret_name,
                "--secret-string",
                "val",
                "--port",
                str(e2e_port),
            ]
        )

        # Act
        result = runner.invoke(
            app,
            [
                "secretsmanager",
                "tag-resource",
                "--secret-id",
                secret_name,
                "--tags",
                json.dumps([{"Key": "env", "Value": "test"}]),
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
