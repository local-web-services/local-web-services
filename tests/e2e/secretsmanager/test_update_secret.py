from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestUpdateSecret:
    def test_update_secret(self, e2e_port, lws_invoke):
        # Arrange
        secret_name = "e2e-update-secret"
        lws_invoke(
            [
                "secretsmanager",
                "create-secret",
                "--name",
                secret_name,
                "--secret-string",
                "old-val",
                "--port",
                str(e2e_port),
            ]
        )

        # Act
        result = runner.invoke(
            app,
            [
                "secretsmanager",
                "update-secret",
                "--secret-id",
                secret_name,
                "--secret-string",
                "new-val",
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
