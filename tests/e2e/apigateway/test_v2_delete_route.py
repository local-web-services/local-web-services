from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestV2DeleteRoute:
    def test_v2_delete_route(self, e2e_port, lws_invoke, assert_invoke):
        # Arrange
        created = lws_invoke(
            [
                "apigateway",
                "v2-create-api",
                "--name",
                "e2e-v2-del-route",
                "--port",
                str(e2e_port),
            ]
        )
        api_id = created["apiId"]
        route = lws_invoke(
            [
                "apigateway",
                "v2-create-route",
                "--api-id",
                api_id,
                "--route-key",
                "DELETE /temp",
                "--port",
                str(e2e_port),
            ]
        )
        route_id = route["routeId"]

        # Act
        result = runner.invoke(
            app,
            [
                "apigateway",
                "v2-delete-route",
                "--api-id",
                api_id,
                "--route-id",
                route_id,
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
