import json

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestGetParametersByPath:
    def test_get_parameters_by_path(self, e2e_port, lws_invoke):
        # Arrange
        path = "/e2e/path-test"
        expected_names = ["/e2e/path-test/p1", "/e2e/path-test/p2"]
        lws_invoke(
            [
                "ssm",
                "put-parameter",
                "--name",
                expected_names[0],
                "--value",
                "a",
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
                expected_names[1],
                "--value",
                "b",
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
                "get-parameters-by-path",
                "--path",
                path,
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
        actual_names = [p["Name"] for p in json.loads(result.output)["Parameters"]]
        for name in expected_names:
            assert name in actual_names
