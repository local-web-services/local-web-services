import json

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestCreateUserPool:
    def test_create_user_pool(self, e2e_port, lws_invoke, assert_invoke):
        # Arrange
        pool_name = "e2e-create-pool"

        # Act
        result = runner.invoke(
            app,
            [
                "cognito-idp",
                "create-user-pool",
                "--pool-name",
                pool_name,
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
        data = json.loads(result.output)
        assert "UserPool" in data
        pool_id = data["UserPool"]["Id"]
        verify = assert_invoke(
            [
                "cognito-idp",
                "describe-user-pool",
                "--user-pool-id",
                pool_id,
                "--port",
                str(e2e_port),
            ]
        )
        actual_name = verify["UserPool"]["Name"]
        assert actual_name == pool_name
