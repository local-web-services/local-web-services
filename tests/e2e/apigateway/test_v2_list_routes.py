import json

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestV2ListRoutes:
    def test_v2_list_routes(self, e2e_port, lws_invoke, assert_invoke):
        # Arrange
        created = lws_invoke(
            [
                "apigateway",
                "v2-create-api",
                "--name",
                "e2e-v2-list-routes",
                "--port",
                str(e2e_port),
            ]
        )
        api_id = created["apiId"]
        lws_invoke(
            [
                "apigateway",
                "v2-create-route",
                "--api-id",
                api_id,
                "--route-key",
                "GET /orders",
                "--port",
                str(e2e_port),
            ]
        )

        # Act
        result = runner.invoke(
            app,
            [
                "apigateway",
                "v2-list-routes",
                "--api-id",
                api_id,
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
        body = json.loads(result.output)
        assert "items" in body
        assert len(body["items"]) >= 1
