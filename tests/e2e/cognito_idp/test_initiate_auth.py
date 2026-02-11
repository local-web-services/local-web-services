import json

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestInitiateAuth:
    def test_initiate_auth(self, e2e_port, lws_invoke):
        # Arrange
        pool_name = "e2e-auth-pool"
        username = "authuser"
        password = "P@ssw0rd!123"
        lws_invoke(
            ["cognito-idp", "create-user-pool", "--pool-name", pool_name, "--port", str(e2e_port)]
        )
        lws_invoke(
            [
                "cognito-idp",
                "sign-up",
                "--user-pool-name",
                pool_name,
                "--username",
                username,
                "--password",
                password,
                "--port",
                str(e2e_port),
            ]
        )
        lws_invoke(
            [
                "cognito-idp",
                "confirm-sign-up",
                "--user-pool-name",
                pool_name,
                "--username",
                username,
                "--port",
                str(e2e_port),
            ]
        )

        # Act
        result = runner.invoke(
            app,
            [
                "cognito-idp",
                "initiate-auth",
                "--user-pool-name",
                pool_name,
                "--username",
                username,
                "--password",
                password,
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
        assert "AuthenticationResult" in json.loads(result.output)
