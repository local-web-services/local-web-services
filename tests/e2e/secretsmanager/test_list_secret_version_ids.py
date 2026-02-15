from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestListSecretVersionIds:
    def test_list_secret_version_ids(self, e2e_port, lws_invoke):
        # Arrange
        secret_name = "e2e-list-version-ids"
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
                "list-secret-version-ids",
                "--secret-id",
                secret_name,
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
