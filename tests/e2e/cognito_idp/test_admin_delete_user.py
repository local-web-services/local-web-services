"""E2E test for Cognito admin-delete-user CLI command."""

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestAdminDeleteUser:
    def test_admin_delete_user(self, e2e_port, lws_invoke):
        # Arrange
        pool_name = "e2e-admin-del-pool"
        result_pool = lws_invoke(
            ["cognito-idp", "create-user-pool", "--pool-name", pool_name, "--port", str(e2e_port)]
        )
        user_pool_id = result_pool["UserPool"]["Id"]
        lws_invoke(
            [
                "cognito-idp",
                "admin-create-user",
                "--user-pool-id",
                user_pool_id,
                "--username",
                "e2e-admin-del-user",
                "--port",
                str(e2e_port),
            ]
        )

        # Act
        result = runner.invoke(
            app,
            [
                "cognito-idp",
                "admin-delete-user",
                "--user-pool-id",
                user_pool_id,
                "--username",
                "e2e-admin-del-user",
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        expected_exit_code = 0
        actual_exit_code = result.exit_code
        assert actual_exit_code == expected_exit_code, result.output
