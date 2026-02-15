"""E2E test for Cognito list-users CLI command."""

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestListUsers:
    def test_list_users(self, e2e_port, lws_invoke):
        # Arrange
        pool_name = "e2e-list-users-pool"
        result_pool = lws_invoke(
            ["cognito-idp", "create-user-pool", "--pool-name", pool_name, "--port", str(e2e_port)]
        )
        user_pool_id = result_pool["UserPool"]["Id"]

        # Act
        result = runner.invoke(
            app,
            [
                "cognito-idp",
                "list-users",
                "--user-pool-id",
                user_pool_id,
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        expected_exit_code = 0
        actual_exit_code = result.exit_code
        assert actual_exit_code == expected_exit_code, result.output
