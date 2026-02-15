"""E2E test for Cognito update-user-pool CLI command."""

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestUpdateUserPool:
    def test_update_user_pool(self, e2e_port, lws_invoke):
        # Arrange
        pool_name = "e2e-update-pool"
        result_pool = lws_invoke(
            ["cognito-idp", "create-user-pool", "--pool-name", pool_name, "--port", str(e2e_port)]
        )
        user_pool_id = result_pool["UserPool"]["Id"]

        # Act
        result = runner.invoke(
            app,
            [
                "cognito-idp",
                "update-user-pool",
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
