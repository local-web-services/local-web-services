import json

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestGetResources:
    def test_get_resources(self, e2e_port, lws_invoke, assert_invoke):
        # Arrange
        created = lws_invoke(
            [
                "apigateway",
                "create-rest-api",
                "--name",
                "e2e-get-resources",
                "--port",
                str(e2e_port),
            ]
        )
        rest_api_id = created["id"]

        # Act
        result = runner.invoke(
            app,
            [
                "apigateway",
                "get-resources",
                "--rest-api-id",
                rest_api_id,
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
        body = json.loads(result.output)
        assert "item" in body
        assert len(body["item"]) >= 1
