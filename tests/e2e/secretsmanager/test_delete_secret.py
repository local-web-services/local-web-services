from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestDeleteSecret:
    def test_delete_secret(self, e2e_port, lws_invoke, assert_invoke):
        # Arrange
        secret_name = "e2e-del-secret"
        lws_invoke(
            [
                "secretsmanager",
                "create-secret",
                "--name",
                secret_name,
                "--secret-string",
                "gone",
                "--port",
                str(e2e_port),
            ]
        )

        # Act
        result = runner.invoke(
            app,
            [
                "secretsmanager",
                "delete-secret",
                "--secret-id",
                secret_name,
                "--force-delete-without-recovery",
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
        verify = assert_invoke(["secretsmanager", "list-secrets", "--port", str(e2e_port)])
        actual_names = [s["Name"] for s in verify.get("SecretList", [])]
        assert secret_name not in actual_names
