from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestGetResourcePolicy:
    def test_get_resource_policy(self, e2e_port, lws_invoke):
        # Arrange
        secret_name = "e2e-get-resource-policy"
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
                "get-resource-policy",
                "--secret-id",
                secret_name,
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
