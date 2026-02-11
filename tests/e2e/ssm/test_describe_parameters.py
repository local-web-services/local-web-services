import json

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestDescribeParameters:
    def test_describe_parameters(self, e2e_port, lws_invoke):
        # Arrange
        param_name = "/e2e/desc-params-test"
        lws_invoke(
            [
                "ssm",
                "put-parameter",
                "--name",
                param_name,
                "--value",
                "x",
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
                "describe-parameters",
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
        actual_names = [p["Name"] for p in json.loads(result.output)["Parameters"]]
        assert param_name in actual_names
