import json

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestSignUp:
    def test_sign_up(self, e2e_port, lws_invoke):
        # Arrange
        pool_name = "e2e-signup-pool"
        lws_invoke(
            ["cognito-idp", "create-user-pool", "--pool-name", pool_name, "--port", str(e2e_port)]
        )

        # Act
        result = runner.invoke(
            app,
            [
                "cognito-idp",
                "sign-up",
                "--user-pool-name",
                pool_name,
                "--username",
                "testuser",
                "--password",
                "P@ssw0rd!123",
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
        assert json.loads(result.output).get("UserConfirmed") is not None
