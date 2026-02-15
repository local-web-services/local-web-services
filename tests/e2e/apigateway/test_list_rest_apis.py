import json

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestListRestApis:
    def test_list_rest_apis(self, e2e_port, lws_invoke, assert_invoke):
        # Arrange
        lws_invoke(
            [
                "apigateway",
                "create-rest-api",
                "--name",
                "e2e-list-rest-apis",
                "--port",
                str(e2e_port),
            ]
        )

        # Act
        result = runner.invoke(
            app,
            [
                "apigateway",
                "list-rest-apis",
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
        body = json.loads(result.output)
        assert "item" in body
