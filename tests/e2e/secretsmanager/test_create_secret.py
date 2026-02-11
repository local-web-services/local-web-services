import json

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestCreateSecret:
    def test_create_secret(self, e2e_port, lws_invoke, assert_invoke):
        # Arrange
        secret_name = "e2e-create-secret"
        expected_value = "s3cret"

        # Act
        result = runner.invoke(
            app,
            [
                "secretsmanager",
                "create-secret",
                "--name",
                secret_name,
                "--secret-string",
                expected_value,
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
        assert json.loads(result.output)["Name"] == secret_name
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

    def test_create_secret_with_description(self, e2e_port, lws_invoke, assert_invoke):
        # Arrange
        secret_name = "e2e-create-secret-desc"

        # Act
        result = runner.invoke(
            app,
            [
                "secretsmanager",
                "create-secret",
                "--name",
                secret_name,
                "--secret-string",
                "val",
                "--description",
                "A test secret",
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
        verify = assert_invoke(
            [
                "secretsmanager",
                "describe-secret",
                "--secret-id",
                secret_name,
                "--port",
                str(e2e_port),
            ]
        )
        actual_name = verify["Name"]
        assert actual_name == secret_name
