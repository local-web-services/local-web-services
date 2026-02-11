from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestPutParameter:
    def test_put_parameter(self, e2e_port, lws_invoke, assert_invoke):
        # Arrange
        param_name = "/e2e/put-param-test"
        expected_value = "test-value"

        # Act
        result = runner.invoke(
            app,
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
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
        verify = assert_invoke(
            ["ssm", "get-parameter", "--name", param_name, "--port", str(e2e_port)]
        )
        actual_value = verify["Parameter"]["Value"]
        assert actual_value == expected_value

    def test_put_parameter_with_description(self, e2e_port, lws_invoke, assert_invoke):
        # Arrange
        param_name = "/e2e/put-param-desc"
        expected_value = "val"

        # Act
        result = runner.invoke(
            app,
            [
                "ssm",
                "put-parameter",
                "--name",
                param_name,
                "--value",
                expected_value,
                "--type",
                "String",
                "--description",
                "A test parameter",
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
        verify = assert_invoke(
            ["ssm", "get-parameter", "--name", param_name, "--port", str(e2e_port)]
        )
        actual_value = verify["Parameter"]["Value"]
        assert actual_value == expected_value

    def test_put_parameter_overwrite(self, e2e_port, lws_invoke, assert_invoke):
        # Arrange
        param_name = "/e2e/put-param-ow"
        expected_value = "v2"
        lws_invoke(
            [
                "ssm",
                "put-parameter",
                "--name",
                param_name,
                "--value",
                "v1",
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
                "put-parameter",
                "--name",
                param_name,
                "--value",
                expected_value,
                "--type",
                "String",
                "--overwrite",
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
        verify = assert_invoke(
            ["ssm", "get-parameter", "--name", param_name, "--port", str(e2e_port)]
        )
        actual_value = verify["Parameter"]["Value"]
        assert actual_value == expected_value
