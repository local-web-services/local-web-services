import json

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestDescribeUserPool:
    def test_describe_user_pool(self, e2e_port, lws_invoke):
        # Arrange
        pool_name = "e2e-desc-pool"
        output = lws_invoke(
            ["cognito-idp", "create-user-pool", "--pool-name", pool_name, "--port", str(e2e_port)]
        )
        pool_id = output["UserPool"]["Id"]

        # Act
        result = runner.invoke(
            app,
            [
                "cognito-idp",
                "describe-user-pool",
                "--user-pool-id",
                pool_id,
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
        actual_name = json.loads(result.output)["UserPool"]["Name"]
        assert actual_name == pool_name
