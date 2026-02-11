import json

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestGetParameter:
    def test_get_parameter(self, e2e_port, lws_invoke):
        # Arrange
        param_name = "/e2e/get-param-test"
        expected_value = "hello"
        lws_invoke(
            [
                "ssm",
                "put-parameter",
                "--name",
                param_name,
                "--value",
                expected_value,
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
                "get-parameter",
                "--name",
                param_name,
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
        actual_value = json.loads(result.output)["Parameter"]["Value"]
        assert actual_value == expected_value
