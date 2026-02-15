"""E2E test for Cognito delete-user-pool-client CLI command."""

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestDeleteUserPoolClient:
    def test_delete_user_pool_client(self, e2e_port, lws_invoke):
        # Arrange
        pool_name = "e2e-del-upc-pool"
        result_pool = lws_invoke(
            ["cognito-idp", "create-user-pool", "--pool-name", pool_name, "--port", str(e2e_port)]
        )
        user_pool_id = result_pool["UserPool"]["Id"]
        result_client = lws_invoke(
            [
                "cognito-idp",
                "create-user-pool-client",
                "--user-pool-id",
                user_pool_id,
                "--client-name",
                "e2e-del-client",
                "--port",
                str(e2e_port),
            ]
        )
        client_id = result_client["UserPoolClient"]["ClientId"]

        # Act
        result = runner.invoke(
            app,
            [
                "cognito-idp",
                "delete-user-pool-client",
                "--user-pool-id",
                user_pool_id,
                "--client-id",
                client_id,
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        expected_exit_code = 0
        actual_exit_code = result.exit_code
        assert actual_exit_code == expected_exit_code, result.output
