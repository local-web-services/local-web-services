from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestRestoreSecret:
    def test_restore_secret(self, e2e_port, lws_invoke):
        # Arrange
        secret_name = "e2e-restore-secret"
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
        lws_invoke(
            [
                "secretsmanager",
                "delete-secret",
                "--secret-id",
                secret_name,
                "--port",
                str(e2e_port),
            ]
        )

        # Act
        result = runner.invoke(
            app,
            [
                "secretsmanager",
                "restore-secret",
                "--secret-id",
                secret_name,
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
