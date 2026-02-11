from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestConfirmSignUp:
    def test_confirm_sign_up(self, e2e_port, lws_invoke):
        # Arrange
        pool_name = "e2e-confirm-pool"
        username = "confirmuser"
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
                "P@ssw0rd!123",
                "--port",
                str(e2e_port),
            ]
        )

        # Act
        result = runner.invoke(
            app,
            [
                "cognito-idp",
                "confirm-sign-up",
                "--user-pool-name",
                pool_name,
                "--username",
                username,
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
