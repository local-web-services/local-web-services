import json

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestV2CreateApi:
    def test_v2_create_api(self, e2e_port, lws_invoke, assert_invoke):
        # Arrange
        api_name = "e2e-v2-create-api"

        # Act
        result = runner.invoke(
            app,
            [
                "apigateway",
                "v2-create-api",
                "--name",
                api_name,
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
        body = json.loads(result.output)
        assert "apiId" in body
        expected_name = api_name
        actual_name = body["name"]
        assert actual_name == expected_name
