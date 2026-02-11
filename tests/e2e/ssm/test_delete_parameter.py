from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestDeleteParameter:
    def test_delete_parameter(self, e2e_port, lws_invoke, assert_invoke):
        # Arrange
        param_name = "/e2e/del-param-test"
        lws_invoke(
            [
                "ssm",
                "put-parameter",
                "--name",
                param_name,
                "--value",
                "gone",
                "--type",
                "String",
                "--port",
                str(e2e_port),
            ]
        )

        # Act
        result = runner.invoke(
            app,
            [
                "ssm",
                "delete-parameter",
                "--name",
                param_name,
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
        verify = assert_invoke(["ssm", "describe-parameters", "--port", str(e2e_port)])
        actual_names = [p["Name"] for p in verify["Parameters"]]
        assert param_name not in actual_names
