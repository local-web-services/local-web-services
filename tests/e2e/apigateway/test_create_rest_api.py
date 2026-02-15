import json

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestCreateRestApi:
    def test_create_rest_api(self, e2e_port, lws_invoke, assert_invoke):
        # Arrange
        api_name = "e2e-create-rest-api"

        # Act
        result = runner.invoke(
            app,
            [
                "apigateway",
                "create-rest-api",
                "--name",
                api_name,
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
        body = json.loads(result.output)
        assert "id" in body
        assert body["name"] == api_name
