import json

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestDescribeSecret:
    def test_describe_secret(self, e2e_port, lws_invoke):
        # Arrange
        secret_name = "e2e-desc-secret"
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
                "describe-secret",
                "--secret-id",
                secret_name,
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
        actual_name = json.loads(result.output)["Name"]
        assert actual_name == secret_name
