from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestDeleteResource:
    def test_delete_resource(self, e2e_port, lws_invoke, assert_invoke):
        # Arrange
        created = lws_invoke(
            [
                "apigateway",
                "create-rest-api",
                "--name",
                "e2e-delete-resource",
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
                "to-delete",
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
                "delete-resource",
                "--rest-api-id",
                rest_api_id,
                "--resource-id",
                resource_id,
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
