import json

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestCreateResource:
    def test_create_resource(self, e2e_port, lws_invoke, assert_invoke):
        # Arrange
        created = lws_invoke(
            [
                "apigateway",
                "create-rest-api",
                "--name",
                "e2e-create-resource",
                "--port",
                str(e2e_port),
            ]
        )
        rest_api_id = created["id"]
        root_resource_id = created["rootResourceId"]

        # Act
        result = runner.invoke(
            app,
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
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
        body = json.loads(result.output)
        expected_path = "/items"
        actual_path = body["path"]
        assert actual_path == expected_path
