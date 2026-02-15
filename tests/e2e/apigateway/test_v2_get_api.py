import json

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestV2GetApi:
    def test_v2_get_api(self, e2e_port, lws_invoke, assert_invoke):
        # Arrange
        created = lws_invoke(
            [
                "apigateway",
                "v2-create-api",
                "--name",
                "e2e-v2-get-api",
                "--port",
                str(e2e_port),
            ]
        )
        api_id = created["apiId"]

        # Act
        result = runner.invoke(
            app,
            [
                "apigateway",
                "v2-get-api",
                "--api-id",
                api_id,
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
        body = json.loads(result.output)
        expected_name = "e2e-v2-get-api"
        actual_name = body["name"]
        assert actual_name == expected_name
