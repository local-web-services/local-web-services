"""E2E test for Cognito change-password CLI command."""

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestChangePassword:
    def test_change_password_via_access_token(self, e2e_port, lws_invoke, assert_invoke):
        # Arrange
        pool_name = "e2e-change-pw-pool"
        username = "e2e-change-pw-user"
        old_password = "P@ssw0rd!123"
        new_password = "N3wP@ssw0rd!"
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
                old_password,
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
                old_password,
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
                "change-password",
                "--access-token",
                access_token,
                "--previous-password",
                old_password,
                "--proposed-password",
                new_password,
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
        new_auth = assert_invoke(
            [
                "cognito-idp",
                "initiate-auth",
                "--user-pool-name",
                pool_name,
                "--username",
                username,
                "--password",
                new_password,
                "--port",
                str(e2e_port),
            ]
        )
        assert "AuthenticationResult" in new_auth
