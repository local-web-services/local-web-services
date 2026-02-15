"""E2E test for Cognito global-sign-out CLI command."""

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestGlobalSignOut:
    def test_global_sign_out_succeeds(self, e2e_port, lws_invoke):
        # Arrange
        pool_name = "e2e-signout-pool"
        username = "e2e-signout-user"
        password = "P@ssw0rd!123"
        lws_invoke(
            [
                "cognito-idp",
                "create-user-pool",
                "--pool-name",
                pool_name,
                "--port",
                str(e2e_port),
            ]
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
        auth_result = lws_invoke(
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
            ]
        )
        access_token = auth_result["AuthenticationResult"]["AccessToken"]

        # Act
        result = runner.invoke(
            app,
            [
                "cognito-idp",
                "global-sign-out",
                "--access-token",
                access_token,
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
