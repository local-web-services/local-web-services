import json

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestPutIntegration:
    def test_put_integration(self, e2e_port, lws_invoke, assert_invoke):
        # Arrange
        created = lws_invoke(
            [
                "apigateway",
                "create-rest-api",
                "--name",
                "e2e-put-integration",
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
                "items",
                "--port",
                str(e2e_port),
            ]
        )
        resource_id = resource["id"]
        lws_invoke(
            [
                "apigateway",
                "put-method",
                "--rest-api-id",
                rest_api_id,
                "--resource-id",
                resource_id,
                "--http-method",
                "POST",
                "--port",
                str(e2e_port),
            ]
        )

        # Act
        result = runner.invoke(
            app,
            [
                "apigateway",
                "put-integration",
                "--rest-api-id",
                rest_api_id,
                "--resource-id",
                resource_id,
                "--http-method",
                "POST",
                "--type",
                "AWS_PROXY",
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
        body = json.loads(result.output)
        expected_type = "AWS_PROXY"
        actual_type = body["type"]
        assert actual_type == expected_type
