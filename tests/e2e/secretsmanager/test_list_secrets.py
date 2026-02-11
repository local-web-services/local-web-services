import json

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestListSecrets:
    def test_list_secrets(self, e2e_port, lws_invoke):
        # Arrange
        secret_name = "e2e-list-secrets"
        lws_invoke(
            [
                "secretsmanager",
                "create-secret",
                "--name",
                secret_name,
                "--secret-string",
                "x",
                "--port",
                str(e2e_port),
            ]
        )

        # Act
        result = runner.invoke(
            app,
            [
                "secretsmanager",
                "list-secrets",
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
        actual_names = [s["Name"] for s in json.loads(result.output)["SecretList"]]
        assert secret_name in actual_names
