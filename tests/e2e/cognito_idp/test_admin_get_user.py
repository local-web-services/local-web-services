"""E2E test for Cognito admin-get-user CLI command."""

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestAdminGetUser:
    def test_admin_get_user(self, e2e_port, lws_invoke):
        # Arrange
        pool_name = "e2e-admin-get-pool"
        username = "e2e-admin-get-user"
        password = "P@ssw0rd!123"
        result_pool = lws_invoke(
            ["cognito-idp", "create-user-pool", "--pool-name", pool_name, "--port", str(e2e_port)]
        )
        user_pool_id = result_pool["UserPool"]["Id"]
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
                "admin-get-user",
                "--user-pool-id",
                user_pool_id,
                "--username",
                username,
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        expected_exit_code = 0
        actual_exit_code = result.exit_code
        assert actual_exit_code == expected_exit_code, result.output
