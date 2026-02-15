import json

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestPutMethod:
    def test_put_method(self, e2e_port, lws_invoke, assert_invoke):
        # Arrange
        created = lws_invoke(
            [
                "apigateway",
                "create-rest-api",
                "--name",
                "e2e-put-method",
                "--port",
                str(e2e_port),
            ]
        )
        rest_api_id = created["id"]
        root_resource_id = created["rootResourceId"]
        resource = lws_invoke(
            [
                "apigateway",
                "create-resource",
                "--rest-api-id",
                rest_api_id,
                "--parent-id",
                root_resource_id,
                "--path-part",
                "orders",
                "--port",
                str(e2e_port),
            ]
        )
        resource_id = resource["id"]

        # Act
        result = runner.invoke(
            app,
            [
                "apigateway",
                "put-method",
                "--rest-api-id",
                rest_api_id,
                "--resource-id",
                resource_id,
                "--http-method",
                "GET",
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
        body = json.loads(result.output)
        expected_method = "GET"
        actual_method = body["httpMethod"]
        assert actual_method == expected_method
