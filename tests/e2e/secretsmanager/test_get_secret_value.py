import json

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestGetSecretValue:
    def test_get_secret_value(self, e2e_port, lws_invoke):
        # Arrange
        secret_name = "e2e-get-sv"
        expected_value = "my-secret"
        lws_invoke(
            [
                "secretsmanager",
                "create-secret",
                "--name",
                secret_name,
                "--secret-string",
                expected_value,
                "--port",
                str(e2e_port),
            ]
        )

        # Act
        result = runner.invoke(
            app,
            [
                "secretsmanager",
                "get-secret-value",
                "--secret-id",
                secret_name,
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
        actual_value = json.loads(result.output)["SecretString"]
        assert actual_value == expected_value
