from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestPutSecretValue:
    def test_put_secret_value(self, e2e_port, lws_invoke, assert_invoke):
        # Arrange
        secret_name = "e2e-put-sv"
        expected_value = "new-value"
        lws_invoke(
            [
                "secretsmanager",
                "create-secret",
                "--name",
                secret_name,
                "--secret-string",
                "old",
                "--port",
                str(e2e_port),
            ]
        )

        # Act
        result = runner.invoke(
            app,
            [
                "secretsmanager",
                "put-secret-value",
                "--secret-id",
                secret_name,
                "--secret-string",
                expected_value,
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
        verify = assert_invoke(
            [
                "secretsmanager",
                "get-secret-value",
                "--secret-id",
                secret_name,
                "--port",
                str(e2e_port),
            ]
        )
        actual_value = verify["SecretString"]
        assert actual_value == expected_value
