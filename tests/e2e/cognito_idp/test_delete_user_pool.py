from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestDeleteUserPool:
    def test_delete_user_pool(self, e2e_port, lws_invoke, assert_invoke):
        # Arrange
        pool_name = "e2e-del-pool"
        output = lws_invoke(
            ["cognito-idp", "create-user-pool", "--pool-name", pool_name, "--port", str(e2e_port)]
        )
        pool_id = output["UserPool"]["Id"]

        # Act
        result = runner.invoke(
            app,
            [
                "cognito-idp",
                "delete-user-pool",
                "--user-pool-id",
                pool_id,
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
        verify = assert_invoke(["cognito-idp", "list-user-pools", "--port", str(e2e_port)])
        actual_names = [p["Name"] for p in verify.get("UserPools", [])]
        assert pool_name not in actual_names
