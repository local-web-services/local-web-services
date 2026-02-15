import json

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestGetParameters:
    def test_get_parameters(self, e2e_port, lws_invoke):
        # Arrange
        param_name_1 = "/e2e/get-params-test-1"
        param_name_2 = "/e2e/get-params-test-2"
        expected_value_1 = "val1"
        expected_value_2 = "val2"
        lws_invoke(
            [
                "ssm",
                "put-parameter",
                "--name",
                param_name_1,
                "--value",
                expected_value_1,
                "--type",
                "String",
                "--port",
                str(e2e_port),
            ]
        )
        lws_invoke(
            [
                "ssm",
                "put-parameter",
                "--name",
                param_name_2,
                "--value",
                expected_value_2,
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
                "get-parameters",
                "--names",
                json.dumps([param_name_1, param_name_2]),
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
