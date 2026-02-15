import json

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestV2CreateRoute:
    def test_v2_create_route(self, e2e_port, lws_invoke, assert_invoke):
        # Arrange
        created = lws_invoke(
            [
                "apigateway",
                "v2-create-api",
                "--name",
                "e2e-v2-create-route",
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
                "v2-create-route",
                "--api-id",
                api_id,
                "--route-key",
                "GET /items",
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
        body = json.loads(result.output)
        assert "routeId" in body
        expected_route = "GET /items"
        actual_route = body["routeKey"]
        assert actual_route == expected_route
