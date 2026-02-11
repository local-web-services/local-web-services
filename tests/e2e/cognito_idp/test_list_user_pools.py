import json

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestListUserPools:
    def test_list_user_pools(self, e2e_port, lws_invoke):
        # Arrange
        pool_name = "e2e-list-pools"
        lws_invoke(
            ["cognito-idp", "create-user-pool", "--pool-name", pool_name, "--port", str(e2e_port)]
        )

        # Act
        result = runner.invoke(
            app,
            [
                "cognito-idp",
                "list-user-pools",
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
        actual_names = [p["Name"] for p in json.loads(result.output)["UserPools"]]
        assert pool_name in actual_names
